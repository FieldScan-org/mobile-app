from fastapi import HTTPException
from sqlalchemy import select

from ..database import SessionDep
from .models import User


async def get_or_create_google_user(user: User, db: SessionDep):
    res = await db.execute(select(User).where(User.email == user.email))
    existing_user = res.scalar_one_or_none()
    if existing_user:
        return existing_user

    db.add(user)
    await db.commit()
    await db.refresh(user)
    return user

async def update_user(user: User, db: SessionDep):
    stmt = select(User).where(User.email == user.email)
    result = await db.execute(stmt)
    existing_user = result.scalar_one()
    
    update_data = user.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(existing_user, key, value)
    
    await db.commit()
    await db.refresh(existing_user)
    return existing_user

    # existing_user.first_name = user.first_name
    # existing_user.last_name = user.last_name
    # existing_user.middle_name = user.middle_name
    # existing_user.picture = user.picture
