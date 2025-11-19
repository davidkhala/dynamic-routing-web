FROM python:slim

WORKDIR /app

RUN pip install uv --root-user-action=ignore

COPY . .

RUN uv pip install --system .

CMD uv run uvicorn main:app --host 0.0.0.0 --port $PORT
