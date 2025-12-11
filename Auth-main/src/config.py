from dotenv import load_dotenv
import os
from pathlib import Path

load_dotenv()

BASE_DIR = Path(__file__).resolve().parent.parent
KEYS_DIR = BASE_DIR / "keys"

JWT_PRIVATE_KEY_PATH = KEYS_DIR / "private.pem"
JWT_PUBLIC_KEY_PATH = KEYS_DIR / "public.pem"

def load_key(path: str):
    try:
        with open(path, "r") as f:
            return f.read()
    except (FileNotFoundError, PermissionError) as e:
        raise RuntimeError(f'Error loading key {path}: {e}')
    

class Settings:
    DB_URL = os.getenv("DB_URL") 
    GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
    GOOGLE_CLIENT_SECRET = os.getenv("GOOGLE_CLIENT_SECRET")
    REDIRECT_URI = "http://localhost:8080/auth/google"

    JWT_PUBLIC_KEY = load_key(JWT_PUBLIC_KEY_PATH)
    JWT_PRIVATE_KEY = load_key(JWT_PRIVATE_KEY_PATH)

settings = Settings()
