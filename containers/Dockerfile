FROM apache/superset:3.1.3@sha256:7208d630cf38910c1146c31c10515c4f3f79ea44d8d6962570aac8f1c7b5548f
USER root

# Add required database driver packages
# https://superset.apache.org/installation.html#database-dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache -r /app/requirements.txt
ENV REQUIREMENTS_LOCAL=/app/requirements.txt

# Custom bootstrap script
COPY docker-bootstrap.sh /app/docker/docker-bootstrap.sh

# Add custom configuration
# https://superset.apache.org/docs/installation/configuring-superset/#configuring-superset
COPY superset_config.py /app/superset_config.py
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

USER superset