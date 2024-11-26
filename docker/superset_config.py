import logging
import os

from celery.schedules import crontab
from flask_appbuilder.security.manager import AUTH_DB, AUTH_OAUTH
from flask_caching.backends.rediscache import RedisCache
from redis import Redis

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

# Caching: https://superset.apache.org/docs/installation/cache
REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = os.getenv("REDIS_PORT", "6379")
REDIS_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}"
REDIS_CELERY_DB = os.getenv("REDIS_CELERY_DB", "0")
REDIS_RESULTS_DB = os.getenv("REDIS_RESULTS_DB", "1")

WEBDRIVER_BASEURL = os.getenv("WEBDRIVER_BASEURL")


def redis_cache(key, timeout):
    return {
        "CACHE_TYPE": "RedisCache",
        "CACHE_DEFAULT_TIMEOUT": timeout,
        "CACHE_KEY_PREFIX": key,
        "CACHE_REDIS_URL": REDIS_URL,
    }


# Cache for 1 day
FILTER_STATE_CACHE_CONFIG = redis_cache("superset_filter_cache_", 60 * 60 * 24)
EXPLORE_FORM_DATA_CACHE_CONFIG = redis_cache(
    "superset_explore_form_data_cache_", 60 * 60 * 24
)  # noqa: E501
DATA_CACHE_CONFIG = redis_cache("superset_data_cache_", 60 * 60 * 24)
CACHE_CONFIG = redis_cache("superset_cache_", 60 * 60 * 24)


# Workers: https://superset.apache.org/docs/installation/async-queries-celery/
class CeleryConfig(object):
    broker_url = f"{REDIS_URL}/{REDIS_CELERY_DB}"
    imports = (
        "superset.sql_lab",
        "superset.tasks.cache",
        "superset.tasks.scheduler",
    )
    result_backend = f"{REDIS_URL}/{REDIS_RESULTS_DB}"
    worker_prefetch_multiplier = 10
    task_acks_late = True
    beat_schedule = {
        "reports.scheduler": {
            "task": "reports.scheduler",
            "schedule": crontab(minute="*", hour="*"),
        },
        "reports.prune_log": {
            "task": "reports.prune_log",
            "schedule": crontab(minute=10, hour=0),
        },
        "cache-warmup-dummy": {
            "task": "cache-warmup",
            "schedule": crontab(minute="*", hour="*/6"),
            "kwargs": {"strategy_name": "dummy"},
        },
    }


CELERY_CONFIG = CeleryConfig
RESULTS_BACKEND = RedisCache(
    host=REDIS_HOST, port=REDIS_PORT, key_prefix="superset_results"
)

# Session management: https://superset.apache.org/docs/security/#user-sessions
SESSION_COOKIE_HTTPONLY = True
SESSION_COOKIE_SECURE = True
SESSION_COOKIE_SAMESITE = "Strict"
SESSION_SERVER_SIDE = True
SESSION_TYPE = "redis"
SESSION_REDIS = Redis(host=REDIS_HOST, port=REDIS_PORT, db=0)

# Google OAuth: https://superset.apache.org/docs/installation/configuring-superset/#custom-oauth2-configuration # noqa: E501
GOOGLE_OAUTH_LOGIN = os.getenv("GOOGLE_OAUTH_LOGIN")
GOOGLE_AUTH_DOMAIN = os.getenv("GOOGLE_AUTH_DOMAIN")
GOOGLE_OAUTH_CLIENT_ID = os.getenv("GOOGLE_OAUTH_CLIENT_ID")
GOOGLE_OAUTH_CLIENT_SECRET = os.getenv("GOOGLE_OAUTH_CLIENT_SECRET")
GOOGLE_OAUTH_EMAIL_DOMAIN = os.getenv("GOOGLE_OAUTH_EMAIL_DOMAIN")
AUTH_TYPE = AUTH_OAUTH if GOOGLE_OAUTH_LOGIN == "true" else AUTH_DB
AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Gamma"
ENABLE_PROXY_FIX = True
OAUTH_PROVIDERS = [
    {
        "name": "google",
        "icon": "fa-google",
        "token_key": "access_token",
        "remote_app": {
            "api_base_url": "https://www.googleapis.com/oauth2/v2/",
            "client_kwargs": {"scope": "email profile"},
            "request_token_url": None,
            "access_token_url": "https://accounts.google.com/o/oauth2/token",
            "authorize_url": "https://accounts.google.com/o/oauth2/auth",
            "client_id": GOOGLE_OAUTH_CLIENT_ID,
            "client_secret": GOOGLE_OAUTH_CLIENT_SECRET,
        },
        "whitelist": [GOOGLE_OAUTH_EMAIL_DOMAIN],
    }
]


RATELIMIT_STORAGE_URI = REDIS_URL
WTF_CSRF_ENABLED = True
WTF_CSRF_EXEMPT_LIST = [
    "superset.views.core.log",
    "superset.views.core.explore_json",
    "superset.charts.data.api.data",
]

SQLLAB_CTAS_NO_LIMIT = True
SIP_15_ENABLED = True

# Custom roles
FAB_ROLES = {
    "ReadOnly": [
        [".*", "can_list"],
        [".*", "can_show"],
        [".*", "menu_access"],
        [".*", "can_get"],
        [".*", "can_info"],
    ]
}

logger.info("Finished setting up custom config for Superset")
