import logging
import os

from celery.schedules import crontab
from flask_appbuilder.security.manager import AUTH_DB, AUTH_OAUTH
from flask_caching.backends.rediscache import RedisCache
from redis import Redis

from superset.integration_tests import database

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
THUMBNAIL_SELENIUM_USER = os.getenv("THUMBNAIL_SELENIUM_USER")


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
        "cache-warmup-charts": {
            "task": "cache-warmup",
            "schedule": crontab(minute=0, hour="*/12"),
            "kwargs": {"strategy_name": "dummy"},
        },
        "cache-warmup-dashboard": {
            "task": "cache-warmup",
            "schedule": crontab(minute=15, hour="*/12"),
            "kwargs": {
                "strategy_name": "top_n_dashboards",
                "top_n": 10,
                "since": "7 days ago",
            },
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
AUTH_USER_REGISTRATION_ROLE = "ReadOnly"
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
    "superset.charts.api.warm_up_cache",
    "superset.dashboards.api.cache_dashboard_screenshot",
]

SQLLAB_CTAS_NO_LIMIT = True
SIP_15_ENABLED = True

FEATURE_FLAGS = {
    "DASHBOARD_RBAC": True,
    "ENABLE_TEMPLATE_PROCESSING": True,
    "ENABLE_SUPERSET_META_DB": True,
    "SQL_VALIDATORS_BY_ENGINE": {
        "presto": "PrestoDBSQLValidator",
    },
}

SUPERSET_META_DB_LIMIT = 1000

LANGUAGES = {
    "en": {"flag": "ca", "name": "English"},
    "fr": {"flag": "ca", "name": "Français"},
}

APP_ICON = "/static/assets/images/logo.png"
FAVICONS = [{"href": "/static/assets/images/logo.png"}]


def app_mutator(app):
    "Run integration tests on app startup"
    if os.getenv("SUPERSET_APP") == "true":
        database.test_access(app)
    return app


FLASK_APP_MUTATOR = app_mutator

# Custom roles
FAB_ROLES = {
    "CacheWarmer": [
        [".*", "can_warm_up_cache"],
        ["all_database_access", "all_database_access"],
        ["all_datasource_access", "all_datasource_access"],
    ],
    "PlatformUser": [],
    "ReadOnly": [
        [".*", "can_external_metadata"],
        [".*", "can_external_metadata_by_name"],
        [".*", "can_get"],
        [".*", "can_info"],
        [".*", "can_list"],
        [".*", "can_read"],
        [".*", "can_show"],
        ["Api", "can_query"],
        ["Api", "can_time_range"],
        ["Dashboard", "can_cache_dashboard_screenshot"],
        ["Dashboard", "can_drill"],
        ["Dashboard", "can_view_chart_as_table"],
        ["Dashboards", "menu_access"],
        ["FilterSets", "can_add"],
        ["FilterSets", "can_delete"],
        ["FilterSets", "can_edit"],
        ["Home", "menu_access"],
        ["Log", "can_recent_activity"],
        ["ResetMyPasswordView", "can_this_form_get"],
        ["ResetMyPasswordView", "can_this_form_post"],
        ["SQLLab", "can_estimate_query_cost"],
        ["SQLLab", "can_format_sql"],
        ["SqlLab", "can_my_queries"],
        ["Superset", "can_dashboard"],
        ["Superset", "can_dashboard_permalink"],
        ["Superset", "can_explore"],
        ["Superset", "can_explore_json"],
        ["Superset", "can_log"],
        ["Superset", "can_profile"],
        ["Superset", "can_share_chart"],
        ["Superset", "can_share_dashboard"],
        ["Superset", "can_slice"],
        ["UserDBModelView", "can_userinfo"],
        ["UserOAuthModelView", "can_userinfo"],
    ],
    "WriteData": [
        ["Chart", "can_write"],
        ["Charts", "menu_access"],
        ["Dashboard", "can_write"],
        ["Dataset", "can_write"],
        ["Datasets", "menu_access"],
        ["TableSchemaView", "can_delete"],
        ["TableSchemaView", "can_expanded"],
        ["TableSchemaView", "can_post"],
        ["TabStateView", "can_delete"],
        ["TabStateView", "can_post"],
    ],
}

logger.info("Finished setting up custom config for Superset")
