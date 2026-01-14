FROM apache/superset:6.0.0@sha256:6f6c9982bd64d81797bd4f33834f2ce4a4653c8ac8322f1e5f9df9b0332d092a
USER root

# Remove unnecessary dependencies
RUN apt-get update && \
    apt-get purge -y \
        libc6-dev \
        libecpg6 \
        libecpg-compat3 \
        libldap-2.5-0 \
        libldap-dev \
        libldap2-dev \
        libpq5 \
        libssl-dev \
        linux-libc-dev \
        xserver-common \
        xvfb && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Add required database driver packages
# https://superset.apache.org/installation.html#database-dependencies
COPY requirements.txt /app/requirements.txt
RUN uv pip install --no-cache-dir -r /app/requirements.txt
ENV REQUIREMENTS_LOCAL=/app/requirements.txt

# Install Chromium
RUN python -m playwright install --with-deps chromium

# Add custom configuration
COPY docker-bootstrap.sh /app/docker/docker-bootstrap.sh
COPY static/assets/images/logo.png /app/superset/static/assets/images/logo.png
COPY static/assets/system-use.js /app/superset/static/assets/system-use.js
COPY superset/integration_tests/ /app/superset/integration_tests/
COPY superset/translations/ /app/superset/translations/
COPY superset/templates/tail_js_custom_extra.html /app/superset/templates/tail_js_custom_extra.html
COPY superset_config.py /app/superset_config.py

ENV SUPERSET_CONFIG_PATH=/app/superset_config.py

USER superset