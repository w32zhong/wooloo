from fastapi import FastAPI
from pydantic import BaseModel


app = FastAPI()


class HelloPerson(BaseModel):
    name: str
    age: int


@app.get("/")
async def read_root():
    return {"message": "Hello World"}


@app.post("/hello")
async def create_item(person: HelloPerson):
    return {"msg": f"Hello {person.name}", "age_next_year": person.age + 1}
