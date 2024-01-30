<img src="https://github.com/apache/superset/raw/master/superset-frontend/src/assets/branding/superset-logo-horiz-apache.png" alt="Superset" width="500"/>
A modern, enterprise-ready business intelligence web application.

## Setup
1. Update the configuration in `./containers/superset_config.py`.
2. Build the Docker image with `make build`.
3. Run Terraform apply with `make apply`.
4. Create the database and admin user:
```bash
# Connect to the ECS task
aws ecs execute-command --cluster superset \
    --container superset \
    --task "$ECS_TASK_ID" \
    --region ca-central-1 \
    --interactive \
    --command "/bin/bash"

# Run database migrations
superset db upgrade

# Create admin user
superset fab create-admin \
    --username admin\
    --firstname Some \
    --lastname Body \
    --email some.body@cds-snc.ca \
    --password "$ADMIN_PASSWORD"

# Setup roles/perms
superset init
```

## Databases
Use the database connection details in `./databases` to connect to datasources.
