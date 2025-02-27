.PHONY: apply build localhost localhost_reset plan fmt install_dev lint

apply:
	@terragrunt apply -var="google_oauth_client_id=$(TF_VAR_GOOGLE_OAUTH_CLIENT_ID)" \
		-var="google_oauth_client_secret=$(TF_VAR_GOOGLE_OAUTH_CLIENT_SECRET)" \
		-var="superset_database_username=$(TF_VAR_SUPERSET_DATABASE_USERNAME)" \
		-var="superset_database_password=$(TF_VAR_SUPERSET_DATABASE_PASSWORD)" \
		-var="superset_secret_key=$(TF_VAR_SUPERSET_SECRET_KEY)" \
		--terragrunt-working-dir terragrunt

build:
	@docker build \
        --file ./docker/Dockerfile \
        --tag superset:latest ./docker

localhost:
	@docker compose up

localhost_reset:
	@docker compose down
	@docker rm -f $(docker ps -aq) || true
	@docker rmi -f $(docker images -q) || true
	@docker volume prune -f
	@docker compose up --build

plan: 
	@terragrunt plan -var="google_oauth_client_id=$(TF_VAR_GOOGLE_OAUTH_CLIENT_ID)" \
		-var="google_oauth_client_secret=$(TF_VAR_GOOGLE_OAUTH_CLIENT_SECRET)" \
		-var="superset_database_username=$(TF_VAR_SUPERSET_DATABASE_USERNAME)" \
		-var="superset_database_password=$(TF_VAR_SUPERSET_DATABASE_PASSWORD)" \
		-var="superset_secret_key=$(TF_VAR_SUPERSET_SECRET_KEY)" \
		--terragrunt-working-dir terragrunt

install_dev:
	@pip install -r ./docker/requirements_dev.txt

fmt: install_dev
	black ./docker $(ARGS)

lint: install_dev
	flake8 --ignore=E501 ./docker
