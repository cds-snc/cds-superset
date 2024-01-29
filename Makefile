.PHONY: plan
plan: 
	@terragrunt plan -var="google_oauth_client_id=$(TF_VAR_GOOGLE_OAUTH_CLIENT_ID)" \
		-var="google_oauth_client_secret=$(TF_VAR_GOOGLE_OAUTH_CLIENT_SECRET)" \
		-var="superset_database_username=$(TF_VAR_SUPERSET_DATABASE_USERNAME)" \
		-var="superset_database_password=$(TF_VAR_SUPERSET_DATABASE_PASSWORD)" \
		-var="superset_secret_key=$(TF_VAR_SUPERSET_SECRET_KEY)" \
		--terragrunt-working-dir terragrunt
	
fmt:
	@terraform fmt -recursive