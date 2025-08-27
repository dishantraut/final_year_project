from fastapi import FastAPI
from fastapi.responses import PlainTextResponse

app = FastAPI()

@app.get("/", response_class=PlainTextResponse)
def index():
    return "Hello from Dockerized FastAPI!"

# Note: Use a production server like Gunicorn with Uvicorn worker in Dockerfile
