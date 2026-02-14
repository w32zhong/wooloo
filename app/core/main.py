from fastapi import FastAPI
from pydantic import BaseModel


app = FastAPI()


class UserItem(BaseModel):
    name: str
    age: int


@app.get("/")
async def read_root():
    return {"message": "Hello World", "status": "active"}


@app.post("/items")
async def create_item(item: UserItem):
    return {"msg": f"Hello {item.name}", "age_next_year": item.age + 1}
