import logging
import os

logger = logging.getLogger()

logger.info("Setting up custom config for Superset")

# Database
DATABASE_USER = os.getenv("SUPERSET_DATABASE_USER")
DATABASE_PASSWORD = os.getenv("SUPERSET_DATABASE_PASSWORD")
DATABASE_HOST = os.getenv("SUPERSET_DATABASE_HOST")
DATABASE_DB = os.getenv("SUPERSET_DATABASE_DB")
SQLALCHEMY_DATABASE_URI = (
    f"postgresql://{DATABASE_USER}:{DATABASE_PASSWORD}@"
    f"{DATABASE_HOST}/{DATABASE_DB}"
)

# Examples: remove for production use
EXAMPLES_DB = os.getenv("EXAMPLES_DATABASE_DB")
SQLALCHEMY_EXAMPLES_URI = (
    f"postgresql://{DATABASE_USER}:{DATABASE_PASSWORD}@"
    f"{DATABASE_HOST}/{EXAMPLES_DB}"
)

# Workers: https://superset.apache.org/docs/installation/async-queries-celery/
CELERY_CONFIG = None

# Caching: https://superset.apache.org/docs/installation/cache
CACHE_CONFIG = {
    "CACHE_TYPE": "SupersetMetastoreCache",
    "CACHE_DEFAULT_TIMEOUT": 300,
    "CACHE_KEY_PREFIX": "superset_",
}
DATA_CACHE_CONFIG = CACHE_CONFIG

SQLLAB_CTAS_NO_LIMIT = True

logger.info("Finished setting up custom config for Superset")
