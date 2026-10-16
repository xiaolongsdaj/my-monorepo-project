from fastapi import FastAPI
from pydantic import BaseModel
import os

is_production = os.getenv("ENVIRONMENT") == "production"

app = FastAPI(
    docs_url=None if is_production else "/docs",
    redoc_url=None if is_production else "/redoc",
    openapi_url=None if is_production else "/openapi.json",
)


class Item(BaseModel):
    name: str
    price: float
    tax: float | None = None


@app.get("/")
def read_root():
    return {"message": "ok"}


# 可以接收查询参数 q 和路径参数 item_id
@app.get("/items/{item_id}")
def read_item(item_id: int, q: str | None = None, w: int = 0):
    return {"item_id": item_id, "q": q, "w": w}


@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_id": item_id, "item": item}
