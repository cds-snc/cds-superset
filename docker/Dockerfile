FROM apache/superset:5.0.0@sha256:ac98e93f50129f4acf234860cdd6b252fd512496017c3c0044ce06528642fa6a
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
RUN uv pip install --no-cache-dir -r /app/requirements.txt
ENV REQUIREMENTS_LOCAL=/app/requirements.txt

# Install Chromium
RUN --mount=type=cache,target=/app/superset_home/.cache/uv \
    playwright install --with-deps chromium

# Add custom configuration
COPY docker-bootstrap.sh /app/docker/docker-bootstrap.sh
COPY static/assets/images/logo.png /app/superset/static/assets/images/logo.png
COPY superset/integration_tests/ /app/superset/integration_tests/
COPY superset/translations/ /app/superset/translations/
COPY superset_config.py /app/superset_config.py

ENV SUPERSET_CONFIG_PATH=/app/superset_config.py

USER superset