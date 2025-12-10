import logging
import os

from datetime import timedelta
from celery.schedules import crontab
from flask import session
from flask_appbuilder.security.manager import AUTH_DB, AUTH_OAUTH
from flask_caching.backends.rediscache import RedisCache
from redis import Redis

from superset.config import TALISMAN_CONFIG
from superset.tasks.types import ExecutorType, FixedExecutor

logger = logging.getLogger()

logger.info("Setting up custom config for Superset")

# Log config
LOG_FORMAT = "%(asctime)s:%(levelname)s:%(name)s:%(message)s"
LOG_LEVEL = logging.INFO

# Database
DATABASE_USER = os.getenv("SUPERSET_DATABASE_USER")
DATABASE_PASSWORD = os.getenv("SUPERSET_DATABASE_PASSWORD")
DATABASE_HOST = os.getenv("SUPERSET_DATABASE_HOST")
DATABASE_DB = os.getenv("SUPERSET_DATABASE_DB")
DATABASE_SSL_MODE = (
    "disable" if os.getenv("SUPERSET_ENV") == "development" else "require"
)
SQLALCHEMY_DATABASE_URI = (
    f"postgresql://{DATABASE_USER}:{DATABASE_PASSWORD}@"
    f"{DATABASE_HOST}/{DATABASE_DB}?sslmode={DATABASE_SSL_MODE}"
)

# Caching: https://superset.apache.org/docs/installation/cache
REDIS_SSL = os.getenv("SUPERSET_ENV") != "development"
REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = os.getenv("REDIS_PORT", "6379")
REDIS_PROTOCOL = "rediss" if REDIS_SSL else "redis"
REDIS_ARGS = "?ssl_cert_reqs=required" if REDIS_SSL else ""
REDIS_URL = f"{REDIS_PROTOCOL}://{REDIS_HOST}:{REDIS_PORT}"
REDIS_CELERY_DB = os.getenv("REDIS_CELERY_DB", "0")
REDIS_RESULTS_DB = os.getenv("REDIS_RESULTS_DB", "1")

CACHE_WARMUP_EXECUTORS = [FixedExecutor(os.getenv("CACHE_WARMUP_EXECUTORS"))]
THUMBNAIL_EXECUTORS = [
    ExecutorType.CURRENT_USER,
    FixedExecutor(os.getenv("CACHE_WARMUP_EXECUTORS")),
]


def redis_cache(key, timeout):
    return {
        "CACHE_TYPE": "RedisCache",
        "CACHE_DEFAULT_TIMEOUT": timeout,
        "CACHE_KEY_PREFIX": key,
        "CACHE_REDIS_URL": REDIS_URL,
    }


DAYS_1 = int(timedelta(days=1).total_seconds())
DAYS_7 = int(timedelta(days=7).total_seconds())
FILTER_STATE_CACHE_CONFIG = redis_cache("superset_filter_cache_", DAYS_1)
EXPLORE_FORM_DATA_CACHE_CONFIG = redis_cache("superset_explore_cache_", DAYS_1)
DATA_CACHE_CONFIG = redis_cache("superset_data_cache_", DAYS_1)
CACHE_CONFIG = redis_cache("superset_cache_", DAYS_1)
THUMBNAIL_CACHE_CONFIG = redis_cache("superset_thumbnail_cache_", DAYS_7)


# Workers: https://superset.apache.org/docs/installation/async-queries-celery/
class CeleryConfig(object):
    broker_url = f"{REDIS_URL}/{REDIS_CELERY_DB}{REDIS_ARGS}"
    imports = (
        "superset.sql_lab",
        "superset.tasks.cache",
        "superset.tasks.scheduler",
        "superset.tasks.thumbnails",
    )
    result_backend = f"{REDIS_URL}/{REDIS_RESULTS_DB}{REDIS_ARGS}"
    worker_prefetch_multiplier = 10
    task_acks_late = True
    task_annotations = {
        "sql_lab.get_sql_results": {
            "rate_limit": "100/s",
        },
    }
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
    }


CELERY_CONFIG = CeleryConfig
RESULTS_BACKEND = RedisCache(
    host=REDIS_HOST,
    port=REDIS_PORT,
    key_prefix="superset_results",
    ssl=REDIS_SSL,
    ssl_cert_reqs="required",
)

# Screenshots
SCREENSHOT_LOCATE_WAIT = int(timedelta(minutes=2).total_seconds())
SCREENSHOT_LOAD_WAIT = int(timedelta(minutes=2).total_seconds())
WEBDRIVER_BASEURL = os.getenv("WEBDRIVER_BASEURL")
WEBDRIVER_BASEURL_USER_FRIENDLY = os.getenv("WEBDRIVER_BASEURL_USER_FRIENDLY")
WEBDRIVER_TYPE = "chrome"
WEBDRIVER_OPTION_ARGS = [
    "--force-device-scale-factor=2.0",
    "--high-dpi-support=2.0",
    "--headless",
    "--disable-gpu",
    "--disable-dev-shm-usage",
    "--no-sandbox",
    "--disable-setuid-sandbox",
    "--disable-extensions",
]

# Session management: https://superset.apache.org/docs/security/#user-sessions
SESSION_COOKIE_HTTPONLY = True
SESSION_COOKIE_SECURE = True
SESSION_COOKIE_SAMESITE = "Strict"
SESSION_SERVER_SIDE = True
SESSION_TYPE = "redis"
SESSION_REDIS = Redis(host=REDIS_HOST, port=REDIS_PORT, db=0)
SESSION_PERMANENT = True
PERMANENT_SESSION_LIFETIME = int(timedelta(hours=12).total_seconds())

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

# Slack and email reports
SLACK_API_TOKEN = os.getenv("SLACK_API_TOKEN")

SMTP_HOST = os.getenv("SMTP_HOST")
SMTP_PORT = 587
SMTP_STARTTLS = True
SMTP_USER = os.getenv("SMTP_USER")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")
SMTP_MAIL_FROM = os.getenv("SMTP_MAIL_FROM")
EMAIL_REPORTS_SUBJECT_PREFIX = "[CDS Superset] "

RATELIMIT_STORAGE_URI = REDIS_URL
WTF_CSRF_ENABLED = True
WTF_CSRF_TIME_LIMIT = int(timedelta(hours=12).total_seconds())
WTF_CSRF_EXEMPT_LIST = [
    "superset.views.core.log",
    "superset.views.core.explore_json",
    "superset.charts.data.api.data",
    "superset.charts.api.warm_up_cache",
    "superset.dashboards.api.cache_dashboard_screenshot",
]

# Embedded dashboard authentication
GUEST_ROLE_NAME = "ReadOnlyGuest"
GUEST_TOKEN_JWT_SECRET = os.getenv("GUEST_TOKEN_JWT_SECRET")
GUEST_TOKEN_JWT_AUDIENCE = "superset"
GUEST_TOKEN_JWT_EXP_SECONDS = int(timedelta(minutes=5).total_seconds())

SQLLAB_CTAS_NO_LIMIT = True
SIP_15_ENABLED = True

FEATURE_FLAGS = {
    "ALERT_REPORTS": True,
    "ALERT_REPORT_SLACK_V2": True,
    "DASHBOARD_RBAC": True,
    "EMBEDDED_SUPERSET": True,
    "ENABLE_DASHBOARD_SCREENSHOT_ENDPOINTS": True,
    "ENABLE_TEMPLATE_PROCESSING": True,
    "ENABLE_SUPERSET_META_DB": True,
    "EXTRA_CATEGORICAL_COLOR_SCHEMES": True,
    "PLAYWRIGHT_REPORTS_AND_THUMBNAILS": True,
    "SQL_VALIDATORS_BY_ENGINE": {
        "presto": "PrestoDBSQLValidator",
    },
    "THUMBNAILS": True,
    "THUMBNAILS_SQLA_LISTENERS": True,
}

SUPERSET_META_DB_LIMIT = 1000

LANGUAGES = {
    "en": {"flag": "ca", "name": "English"},
    "fr": {"flag": "ca", "name": "Français"},
}

APP_ICON = "/static/assets/images/logo.png"
FAVICONS = [{"href": "/static/assets/images/logo.png"}]

# Custom color palettes for charts based on official CDS Design System
EXTRA_CATEGORICAL_COLOR_SCHEMES = [
    {
        "id": "cds_platform",
        "description": "CDS Platform Brand Colors",
        "label": "CDS Platform",
        "colors": [
            "#3A4455",  # Platform Dark
            "#B5C0CB",  # Platform Medium
            "#CFD6DD",  # Platform Light
            "#000000",  # Black
            "#666666",  # Medium Gray
            "#999999",  # Light Gray
            "#B7B7B7",  # Lighter Gray
            "#EFEFEF",  # White
        ],
    },
    {
        "id": "cds_notify",
        "description": "GC Notify Brand Colors",
        "label": "GC Notify",
        "colors": [
            "#294162",  # Notify Dark Blue
            "#5BAAD7",  # Notify Medium Blue
            "#8CD0F2",  # Notify Light Blue
            "#000000",  # Black
            "#666666",  # Medium Gray
            "#999999",  # Light Gray
            "#B7B7B7",  # Lighter Gray
            "#EFEFEF",  # White
        ],
    },
    {
        "id": "cds_forms",
        "description": "GC Forms Brand Colors",
        "label": "GC Forms",
        "colors": [
            "#4B4085",  # Forms Dark Purple
            "#9D8CF2",  # Forms Medium Purple
            "#CEC5F8",  # Forms Light Purple
            "#000000",  # Black
            "#666666",  # Medium Gray
            "#999999",  # Light Gray
            "#B7B7B7",  # Lighter Gray
            "#EFEFEF",  # White
        ],
    },
    {
        "id": "cds_design_system",
        "description": "GC Design System Colors",
        "label": "GC Design System",
        "colors": [
            "#03662A",  # Design System Dark Green
            "#58C180",  # Design System Medium Green
            "#9FDFBA",  # Design System Light Green
            "#000000",  # Black
            "#666666",  # Medium Gray
            "#999999",  # Light Gray
            "#B7B7B7",  # Lighter Gray
            "#EFEFEF",  # White
        ],
    },
]


def app_mutator(app):
    """
    Run integration tests on app startup and fix menu translations
    when language changes.
    """

    # Run integration tests if needed
    if os.getenv("SUPERSET_APP") == "true":
        from superset.integration_tests import database

        database.test_access(app)

    # Workaround bug in Superset not updating the main menu translations
    @app.before_request
    def fix_menu_translations():
        """
        Retrieve the current locale and check if it has changed.  If it has,
        rebuild the top level menu labels for the new locale.
        """
        menu_translations = {
            "en": {
                "Dashboards": "Dashboards",
                "Charts": "Charts",
                "Datasets": "Datasets",
                "SQL Lab": "SQL",
                "SQL Editor": "SQL Lab",
                "Saved Queries": "Saved Queries",
                "Query Search": "Query History",
            },
            "fr": {
                "Dashboards": "Tableaux de bords",
                "Charts": "Graphiques",
                "Datasets": "Ensembles de données",
                "SQL Lab": "SQL",
                "SQL Editor": "Laboratoire SQL",
                "Saved Queries": "Requêtes enregistrées",
                "Query Search": "Historique des requêtes",
            },
        }
        locale = session.get("locale")
        locale_previous = session.get("locale_previous")
        if locale != locale_previous:
            session["locale_previous"] = locale
            menu = (
                app.appbuilder.menu
                if hasattr(app, "appbuilder") and hasattr(app.appbuilder, "menu")
                else None
            )
            if locale and menu:
                for item in menu.get_list():
                    item.label = menu_translations.get(locale, {}).get(
                        item.name, item.label
                    )
                    for child in item.childs:
                        child.label = menu_translations.get(locale, {}).get(
                            child.name, child.label
                        )

    return app


TALISMAN_ENABLED = True
TALISMAN_CONFIG["content_security_policy"]["frame-ancestors"] = [
    "'self'",
    "http://localhost:3000",
    "https://https://backstage.cdssandbox.xyz",
]


FLASK_APP_MUTATOR = app_mutator

# Custom roles
FAB_ROLES = {
    "CacheWarmer": [
        [".*", "can_warm_up_cache"],
        ["all_database_access", "all_database_access"],
        ["all_datasource_access", "all_datasource_access"],
    ],
    "PlatformUser": [],
    "ReadOnlyGuest": [],
    "ReadOnly": [
        [".*", "can_external_metadata"],
        [".*", "can_external_metadata_by_name"],
        [".*", "can_get"],
        [".*", "can_info"],
        [".*", "can_list"],
        [".*", "can_read"],
        [".*", "can_show"],
        ["Api", "can_query"],
        ["Api", "can_query_form_data"],
        ["Api", "can_time_range"],
        ["Chart", "can_export"],
        ["ColumnarToDatabaseView", "can_this_form_get"],
        ["ColumnarToDatabaseView", "can_this_form_post"],
        ["Dashboard", "can_cache_dashboard_screenshot"],
        ["Dashboard", "can_drill"],
        ["Dashboard", "can_view_chart_as_table"],
        ["Dashboards", "menu_access"],
        ["FilterSets", "can_add"],
        ["FilterSets", "can_delete"],
        ["FilterSets", "can_edit"],
        ["Home", "menu_access"],
        ["Log", "can_recent_activity"],
        ["Manage", "menu_access"],
        ["ReportSchedule", "can_read"],
        ["ReportSchedule", "can_write"],
        ["ResetMyPasswordView", "can_this_form_get"],
        ["ResetMyPasswordView", "can_this_form_post"],
        ["SQLLab", "can_estimate_query_cost"],
        ["SQLLab", "can_format_sql"],
        ["SqlLab", "can_my_queries"],
        ["Superset", "can_csv"],
        ["Superset", "can_dashboard"],
        ["Superset", "can_dashboard_permalink"],
        ["Superset", "can_explore"],
        ["Superset", "can_explore_json"],
        ["Superset", "can_log"],
        ["Superset", "can_profile"],
        ["Superset", "can_share_chart"],
        ["Superset", "can_share_dashboard"],
        ["Superset", "can_slice"],
        ["Superset", "can_schemas"],
        ["UserDBModelView", "can_userinfo"],
        ["UserOAuthModelView", "can_userinfo"],
    ],
    "WriteData": [
        ["Chart", "can_write"],
        ["Charts", "menu_access"],
        ["Dashboard", "can_write"],
        ["Dataset", "can_write"],
        ["Datasets", "menu_access"],
        ["ExploreFormDataRestApi", "can_write"],
        ["TableSchemaView", "can_delete"],
        ["TableSchemaView", "can_expanded"],
        ["TableSchemaView", "can_post"],
        ["TabStateView", "can_delete"],
        ["TabStateView", "can_post"],
        ["TagView", "can_delete"],
        ["TagView", "can_post"],
    ],
}

logger.info("Finished setting up custom config for Superset")
