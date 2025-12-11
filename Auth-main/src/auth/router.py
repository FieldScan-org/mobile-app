from sqlalchemy import select
from fastapi import APIRouter, Request, Response, HTTPException, Depends, status
from fastapi.responses import RedirectResponse
from google.oauth2 import id_token
from google.auth.transport import requests
import aiohttp

from ..database import SessionDep
from .utils import generate_google_auth_redirect_url, generate_jwt_token, verify_password, hash_password, verify_jwt_token
from ..config import settings
from ..users.service import update_user, get_or_create_google_user
from ..users.models import User
from ..users.schemas import UserLogin, UserCreate, UserResponse

router = APIRouter(tags=["auth"])

@router.get("/authenticate", response_model=UserResponse)
async def authenticate(request: Request, db: SessionDep):
    token = request.cookies.get("access_token")
    print('\n\n')
    print('token')
    print(token)
    print('\n\n')

    if not token:
        raise HTTPException(status_code=401, detail="Not authenticated")

    encoded = verify_jwt_token(token=token)
    
    query = select(User).where(User.id == int(encoded["sub"]))
    result = await db.execute(query)
    user = result.scalar_one_or_none()

    return user


@router.post("/login")
async def login(user: UserLogin, response: Response, db: SessionDep):
    stmt = select(User).where(User.email == user.email)
    result = await db.execute(stmt)
    db_user = result.scalar_one_or_none()
    if not db_user or not verify_password(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    access_token = generate_jwt_token(str(db_user.id), 10080)

    response.set_cookie(key="access_token", value=access_token, httponly=True, secure=False)
    return {"message": "Login successful"}

@router.post("/register", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def register(response: Response, user: UserCreate, db: SessionDep):
    res = await db.execute(select(User).where(User.email == user.email))
    existing_user = res.scalar_one_or_none()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    new_user = User(
        email=user.email,
        first_name=user.first_name,
        middle_name=user.middle_name,
        last_name=user.last_name,
        picture=user.picture,
        password=hash_password(user.password),
    )

    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)

    access_token = generate_jwt_token(new_user.id, 10080)
    response.set_cookie(key="access_token", value=access_token, httponly=True, secure=False)

    return {"message": "Registration successful"}

@router.get("/google/url")
async def get_google_auth_redirect_uri():
    uri = generate_google_auth_redirect_url()
    return RedirectResponse(url=uri, status_code=302)


@router.get("/google")
async def callback(request: Request, response: Response, db: SessionDep, code: str = None, error: str = None):
    if error:
        return  {"error": error}
    if not code:
        raise HTTPException(status_code=400, detail="No code provided")

    google_token_url = "https://oauth2.googleapis.com/token"
    
    async with aiohttp.ClientSession() as session:
        async with session.post(
            url=google_token_url,
            data={
                "code": code,
                "client_id": settings.GOOGLE_CLIENT_ID,
                "client_secret": settings.GOOGLE_CLIENT_SECRET,
                "redirect_uri": settings.REDIRECT_URI,
                "grant_type": "authorization_code",
            },
                                ) as aiohttp_response:
            res = await aiohttp_response.json()
            print(f'res: {res}')

            if "error" in res:
                raise HTTPException(status_code=400, detail=res["error"])
            
            id_token_str = res["id_token"]

            try:
                user_data = id_token.verify_oauth2_token(
                    id_token_str, 
                    requests.Request(),
                    settings.GOOGLE_CLIENT_ID
                )
            except ValueError as e:
                raise HTTPException(status_code=400, detail=f"Invalid ID token: {str(e)}")
            
            for i in user_data:
                print(f'{i}: {user_data[i]}')

            google_user = User(
                email=user_data["email"],
                first_name=user_data.get("given_name") or user_data.get("name") or "",
                last_name=user_data.get("family_name", ""),
                picture=user_data.get("picture", "")
            )

            user = await get_or_create_google_user(user=google_user, db=db)

            if (
                user.email != google_user.email or
                user.first_name != google_user.first_name or 
                user.last_name != google_user.last_name or
                user.picture != google_user.picture
            ):
                update_user(user=google_user, db=db)

            access_token = generate_jwt_token(str(user.id), 10080)

            redirect_response = RedirectResponse(url="http://localhost:3000/home", status_code=302)
            redirect_response.set_cookie(key="access_token", value=access_token, httponly=True, secure=False)
            return redirect_response