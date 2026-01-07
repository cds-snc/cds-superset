FROM apache/superset:6.0.0@sha256:6f6c9982bd64d81797bd4f33834f2ce4a4653c8ac8322f1e5f9df9b0332d092a
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
    uv pip install --no-cache-dir playwright

ENV PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/pw-browsers
RUN python -m playwright install --with-deps chromium \
 && chmod -R a+rX /usr/local/share/pw-browsers
 
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