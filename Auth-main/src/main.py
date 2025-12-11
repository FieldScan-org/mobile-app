from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

from .auth.router import router as auth_router
from .router import router as root_router
from .database import setup_database, drop_database


origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

@asynccontextmanager
async def lifespan(app: FastAPI):
    # await drop_database()
    await setup_database()
    yield

app = FastAPI(lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth_router, prefix="/auth")
app.include_router(root_router, prefix="")


@app.get("/")
def root():
    return {"message": "hellow world"}


if __name__ == "__main__":
    uvicorn.run("main:app", port=8080, reload=True)