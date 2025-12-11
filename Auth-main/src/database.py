from typing import Annotated
from fastapi import Depends
from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker, AsyncSession

from .config import settings
from .models import Base
from .users.models import User

engine = create_async_engine(settings.DB_URL, echo=True)
new_session = async_sessionmaker(engine, expire_on_commit=False)

async def get_session():
    async with new_session() as session:
        yield session

SessionDep = Annotated[AsyncSession, Depends(get_session)]

async def drop_database():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)

async def setup_database():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)