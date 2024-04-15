FROM apache/superset:3.1.2@sha256:0106a05a9e612df6c5972cc28e4712ff4a9ab2972665bad384aff6e5ef3112c8
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