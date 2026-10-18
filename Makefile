.PHONY: dev debug db-migrate db-upgrade db-downgrade
dev:
	set PYTHONDONTWRITEBYTECODE=1 && uv run --package web-service fastapi dev apps/web-service/app/main.py --port 8080

debug:
	set PYTHONDONTWRITEBYTECODE=1 && uv run --package web-service python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m fastapi dev apps/web-service/app/main.py --port 8000
db-migrate:
	set PYTHONDONTWRITEBYTECODE=1 && uv run --package web-service alembic -c apps/web-service/alembic.ini revision --autogenerate -m "$(message)"

db-upgrade:
	set PYTHONDONTWRITEBYTECODE=1 && uv run --package web-service alembic -c apps/web-service/alembic.ini upgrade head

db-downgrade:
	set PYTHONDONTWRITEBYTECODE=1 && uv run --package web-service alembic -c apps/web-service/alembic.ini downgrade $(version)