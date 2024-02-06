.PHONY: apply build plan fmt install_dev lint

apply:
	@terragrunt apply -var="google_oauth_client_id=$(TF_VAR_GOOGLE_OAUTH_CLIENT_ID)" \
		-var="google_oauth_client_secret=$(TF_VAR_GOOGLE_OAUTH_CLIENT_SECRET)" \
		-var="superset_database_username=$(TF_VAR_SUPERSET_DATABASE_USERNAME)" \
		-var="superset_database_password=$(TF_VAR_SUPERSET_DATABASE_PASSWORD)" \
		-var="superset_secret_key=$(TF_VAR_SUPERSET_SECRET_KEY)" \
		--terragrunt-working-dir terragrunt

build:
	@docker build \
        --file ./containers/Dockerfile \
        --tag superset:latest ./containers

plan: 
	@terragrunt plan -var="google_oauth_client_id=$(TF_VAR_GOOGLE_OAUTH_CLIENT_ID)" \
		-var="google_oauth_client_secret=$(TF_VAR_GOOGLE_OAUTH_CLIENT_SECRET)" \
		-var="superset_database_username=$(TF_VAR_SUPERSET_DATABASE_USERNAME)" \
		-var="superset_database_password=$(TF_VAR_SUPERSET_DATABASE_PASSWORD)" \
		-var="superset_secret_key=$(TF_VAR_SUPERSET_SECRET_KEY)" \
		--terragrunt-working-dir terragrunt

install_dev:
	@pip install -r ./containers/requirements_dev.txt

fmt: install_dev
	black ./containers $(ARGS)

lint: install_dev
	flake8 ./containers
