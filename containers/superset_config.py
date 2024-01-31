import logging
import os

from flask_appbuilder.security.manager import AUTH_DB, AUTH_OAUTH

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
# Cache for 12 hours
FILTER_STATE_CACHE_CONFIG = redis_cache("superset_filter_cache_", 43200)
EXPLORE_FORM_DATA_CACHE_CONFIG = redis_cache("superset_explore_form_data_cache_", 43200)
DATA_CACHE_CONFIG = redis_cache("superset_data_cache_", 43200)
CACHE_CONFIG = redis_cache("superset_cache_", 43200)

# Google OAuth: https://superset.apache.org/docs/installation/configuring-superset/#custom-oauth2-configuration
GOOGLE_OAUTH_LOGIN = os.getenv("GOOGLE_OAUTH_LOGIN")
GOOGLE_AUTH_DOMAIN = os.getenv("GOOGLE_AUTH_DOMAIN")
GOOGLE_OAUTH_CLIENT_ID = os.getenv("GOOGLE_OAUTH_CLIENT_ID")
GOOGLE_OAUTH_CLIENT_SECRET = os.getenv("GOOGLE_OAUTH_CLIENT_SECRET")
GOOGLE_OAUTH_EMAIL_DOMAIN = os.getenv("GOOGLE_OAUTH_EMAIL_DOMAIN")
AUTH_TYPE = AUTH_OAUTH if GOOGLE_OAUTH_LOGIN == "true" else AUTH_DB
AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Alpha"
ENABLE_PROXY_FIX = True
OAUTH_PROVIDERS = [
    {
        "name": "google",
        "icon": "fa-google",
        "token_key": "access_token",
        "remote_app": {
            "api_base_url": "https://www.googleapis.com/oauth2/v2/",
            "client_kwargs": {
                "scope": "email profile"
            },
            "request_token_url": None,
            "access_token_url": "https://accounts.google.com/o/oauth2/token",
            "authorize_url": "https://accounts.google.com/o/oauth2/auth",
            "client_id": GOOGLE_OAUTH_CLIENT_ID,
            "client_secret": GOOGLE_OAUTH_CLIENT_SECRET
        },
        "whitelist": [GOOGLE_OAUTH_EMAIL_DOMAIN],
    }
]

SQLLAB_CTAS_NO_LIMIT = True

logger.info("Finished setting up custom config for Superset")
