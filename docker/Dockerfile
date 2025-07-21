FROM apache/superset:4.1.3@sha256:31d965435b462361d2b8207595eff28f54492778d0afd53768da5e763cc16ce7
USER root

# Remove dev dependencies
RUN apt-get update && \
    apt-get purge linux-libc-dev libc6-dev libldap-dev libldap2-dev libssl-dev -y && \
    apt-get autoremove -y && \
    apt-get install libecpg-dev -y && \
    rm -rf /var/lib/apt/lists/*

# Add required database driver packages
# https://superset.apache.org/installation.html#database-dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt
ENV REQUIREMENTS_LOCAL=/app/requirements.txt

# Custom bootstrap script
COPY docker-bootstrap.sh /app/docker/docker-bootstrap.sh

# Add custom configuration
# https://superset.apache.org/docs/installation/configuring-superset/#configuring-superset
COPY superset/integration_tests/ /app/superset/integration_tests/
COPY superset_config.py /app/superset_config.py
COPY static/assets/images/logo.png /app/superset/static/assets/images/logo.png
ENV SUPERSET_CONFIG_PATH=/app/superset_config.py

USER superset