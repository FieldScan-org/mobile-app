import urllib.parse
import jwt
from datetime import datetime, timedelta
from passlib.context import CryptContext

from ..config import settings
from ..users.models import User
from ..config import settings

def generate_google_auth_redirect_url():
    query_params = {
        "client_id": settings.GOOGLE_CLIENT_ID,
        "redirect_uri": "http://localhost:8080/auth/google",
        "response_type": "code",
        "scope": " ".join([
            "openid",
            "profile",
            "email"
        ]),
        "access_type": "offline"
        
    }
    
    query_string = urllib.parse.urlencode(query_params, quote_via=urllib.parse.quote)
    base_url = "https://accounts.google.com/o/oauth2/v2/auth"
    return f'{base_url}?{query_string}'

def generate_jwt_token(sub: str, expires_in_minutes: int):
    payload = {
        "sub": sub,
        "exp": datetime.now() + timedelta(minutes=expires_in_minutes)
    }
    token = jwt.encode(payload=payload, key=settings.JWT_PRIVATE_KEY, algorithm="RS256")

    return token

def verify_jwt_token(token: str):
    decoded = jwt.decode(token, key=settings.JWT_PUBLIC_KEY, algorithms=["RS256"])
    print(f'\n\ndecoded:\n{decoded}\n\n')
    return decoded


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    # print(f"Hashing password: {repr(password)} ({len(password)} chars)")
    return pwd_context.hash(password)

def verify_password(password: str, hashed: str) -> bool:
    return pwd_context.verify(password, hashed)
