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
REDIS_URL = os.getenv("CACHE_REDIS_URL")

def redis_cache (key, timeout) :
    return {
        'CACHE_TYPE': 'RedisCache',
        'CACHE_DEFAULT_TIMEOUT': timeout,
        'CACHE_KEY_PREFIX': key,
        'CACHE_REDIS_URL': REDIS_URL
    }

FILTER_STATE_CACHE_CONFIG = redis_cache("superset_filter_cache_", 300)
EXPLORE_FORM_DATA_CACHE_CONFIG = redis_cache("superset_explore_form_data_cache_", 300)
DATA_CACHE_CONFIG = redis_cache("superset_data_cache_", 300)
CACHE_CONFIG = redis_cache("superset_cache_", 300)

SQLLAB_CTAS_NO_LIMIT = True

logger.info("Finished setting up custom config for Superset")
