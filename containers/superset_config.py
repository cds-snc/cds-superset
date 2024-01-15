import logging


logger = logging.getLogger()


logger.info("Setting up custom config for Superset")


CACHE_CONFIG = {
    "CACHE_TYPE": "SupersetMetastoreCache",
    "CACHE_DEFAULT_TIMEOUT": 300,
    "CACHE_KEY_PREFIX": "superset_",
}
DATA_CACHE_CONFIG = CACHE_CONFIG
CELERY_CONFIG = None


logger.info("Finished setting up custom config for Superset")