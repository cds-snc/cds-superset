FROM apache/superset:4.1.1@sha256:1d1fdaaeb19ce9cdba71620ee1cc6117d73813b2f3b422ce5a1bf752c247b7c0
USER root

# Add required database driver packages
# https://superset.apache.org/installation.html#database-dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt
ENV REQUIREMENTS_LOCAL=/app/requirements.txt

# Custom bootstrap script
COPY docker-bootstrap.sh /app/docker/docker-bootstrap.sh

# Add custom configuration
# https://superset.apache.org/docs/installation/configuring-superset/#configuring-superset
COPY superset_config.py /app/superset_config.py
ENV SUPERSET_CONFIG_PATH=/app/superset_config.py

# Code overrides
# BUG in 4.1.1 for cache warming.  Remove when the fix is released.
COPY superset/tasks/cache.py /app/superset/tasks/cache.py

USER superset