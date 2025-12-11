from fastapi import Request, APIRouter, HTTPException
from sqlalchemy import select

from .auth.utils import verify_jwt_token
from .database import SessionDep 
from .users.models import User
from .users.schemas import UserResponse

router = APIRouter(prefix="")

@router.get("/home", response_model=UserResponse)
async def home(request: Request, db: SessionDep):
    token = request.cookies.get("access_token")
    if not token:
        raise HTTPException(status_code=401, detail="Not authenticated")

    encoded = verify_jwt_token(token=token)

    query = select(User).where(User.id == int(encoded["sub"]))
    result = await db.execute(query)
    user = result.scalar_one_or_none()

    return user