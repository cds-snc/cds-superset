FROM apache/superset:3.1.0@sha256:afcd2f63479e29da06944087a29e7788f9ecd0250f4611e52aee1c844187e3eb
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