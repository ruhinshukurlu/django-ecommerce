.PHONY: superuser
superuser:
	poetry run python manage.py createsuperuser

.PHONY: install
install:
	poetry install

.PHONY: migrations
migrations:
	poetry run python manage.py makemigrations

.PHONY: migrate
migrate:
	poetry run python manage.py migrate

.PHONY: install-pre-commit
install-pre-commit:
	poetry run pre-commit uninstall; poetry run pre-commit install

.PHONY: dc-up
dc-up:
	test -f .env || touch .env
	docker-compose -f docker-compose.dev.yml up -d --force-recreate db

.PHONY: dc-down
dc-down:
	docker-compose -f docker-compose.dev.yml down

.PHONY: update
update: install migrate install-pre-commit ;

.PHONY: runserver
runserver:
	poetry run python manage.py runserver 127.0.0.1:8000

.PHONY: lint
lint:
	poetry run pre-commit run --all-files
