# FieldScan Backend

Small FastAPI backend that provides user authentication (Google OAuth + JWT) and basic user management.

## Quick links
- Main app entry: [src/main.py](src/main.py)  
- Auth router: [`auth.router.router`](src/auth/router.py) — [src/auth/router.py](src/auth/router.py)  
- Auth helpers: [`auth.utils.generate_google_auth_redirect_url`](src/auth/utils.py), [`auth.utils.generate_jwt_token`](src/auth/utils.py), [`auth.utils.verify_jwt_token`](src/auth/utils.py) — [src/auth/utils.py](src/auth/utils.py)  
- DB setup & dependency: [`database.SessionDep`](src/database.py) — [src/database.py](src/database.py)  
- Users service & models: [`users.service.get_or_create_google_user`](src/users/service.py), [`users.service.update_user`](src/users/service.py), [`users.service.get_user`](src/users/service.py), [src/users/models.py](src/users/models.py), [src/users/schemas.py](src/users/schemas.py)  
- App root router: [`router.router`](src/router.py) — [src/router.py](src/router.py)  
- App config: [`config.settings`](src/config.py) — [src/config.py](src/config.py)  
- Requirements: [requirements.txt](requirements.txt)  
- Dockerfile: [Dockerfile]

## Features
- Google OAuth2 sign-in flow (redirect, token exchange, ID token verification).
  - Redirect URL generator: [`auth.utils.generate_google_auth_redirect_url`](src/auth/utils.py).
  - Token creation (JWT signed with RSA keys): [`auth.utils.generate_jwt_token`](src/auth/utils.py).
  - JWT verification: [`auth.utils.verify_jwt_token`](src/auth/utils.py).
- Persistent users stored via SQLAlchemy declarative models ([src/users/models.py](src/users/models.py)).
- Asynchronous DB sessions via SQLAlchemy async engine and sessionmaker ([src/database.py](src/database.py)).
- Simple templates for login, callback and user home pages under [templates/](templates/).

## Environment
Copy `.env.example` to `.env` and set values, or use environment variables:
- DB_URL (default in repo: sqlite+aiosqlite:///auth.db) — see [src/config.py](src/config.py) and [.env.example](.env.example)
- GOOGLE_CLIENT_ID
- GOOGLE_CLIENT_SECRET

The app reads RSA keys from the `keys/` directory:
- keys/private.pem
- keys/public.pem  
These are loaded by [`config.settings`](src/config.py).

### Key generation
- If you need to generate keys locally, run:
```bash
mkdir -p keys
openssl genrsa -out keys/private.pem 2048
openssl rsa -in keys/private.pem -pubout -out keys/public.pem
chmod 600 keys/private.pem
chmod 644 keys/public.pem
```
- Note: Dockerfile can't generate keys, so you need to generate them first; keys are required at runtime.

## Local development

1. Create a virtual environment and install deps:
```bash
python -m venv venv
source venv/bin/activate  # On Windows use `venv\Scripts\activate` or 'venv\Scripts\Activate.ps1'
pip install -r requirements.txt
```

2. Ensure `.env` is present and keys exist. By default the repo uses SQLite `auth.db`.

3. Run the app:
```bash
uvicorn src.main:app --reload --port 8080 --host 127.0.0.1
```
`src/main.py` sets up the DB on startup via [`database.setup_database`](src/database.py).

4. Open the login page:
- GET /auth/login — handled by [`auth.router.router`](src/auth/router.py) and renders [templates/index.html](templates/index.html).
- The login button follows `/auth/google/url` which redirects to Google OAuth consent.

## Endpoints (summary)
GET / → health check — implemented in src/main.py
GET /auth/login → login page — src/auth/router.py
GET /auth/google/url → returns RedirectResponse to Google — src/auth/router.py
GET /auth/google → OAuth callback; exchanges code for tokens, verifies ID token, creates/updates user and sets JWT cookie — src/auth/router.py
POST /auth/login → local login using email/password — src/auth/router.py
POST /auth/register → local registration — src/auth/router.py
GET /home → protected route that reads cookie token and returns user — src/router.py

## Notes & gotchas
- JWT signing uses RSA keys in `keys/` and is configured in [src/config.py](src/config.py). If keys are missing the app will raise at import time.
- The OAuth redirect URI configured in code: `http://localhost:8080/auth/google` (see [`auth.utils.generate_google_auth_redirect_url`](src/auth/utils.py) and [`config.settings.REDIRECT_URI`](src/config.py)).
- The OAuth flow uses `aiohttp` to exchange code for tokens in [`auth.router.callback`](src/auth/router.py).

## Docker
- Note: You need to generate keys locally first as described above, since the app requires them at runtime. See "Key generation" section.

The included [Dockerfile](Dockerfile) installs deps. To build and run:
```bash
docker build -t fieldscan-auth .
docker run -p 8080:8080 fieldscan-auth
```

## License