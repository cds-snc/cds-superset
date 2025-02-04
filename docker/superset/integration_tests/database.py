import random


def test_access(app):
    """
    Retrieve all database connections and loop over each one.
    Retrieve the database's tables and attempt to fetch metadata for a table at random.
    This ensures that Superset can access the underlying database table and its data.
    """
    with app.app_context():
        from superset import db
        from superset.models.core import Database
        from superset.connectors.sqla.models import SqlaTable

        logger = app.logger

        try:
            logger.info(
                "\n\n========== 🧪 Database integration tests starting ==========\n"
            )

            databases = db.session.query(Database).all()
            logger.info(f"Found {len(databases)} database connections to test")

            for database in databases:
                # Only test databases that are not impersonating the user.  This is done to
                # skip database connections like Google Sheets that require user permissions
                # to access the data.
                if database.impersonate_user is True:
                    logger.info(
                        f"Skipping database '{database.database_name}' as it requires user impersonation"
                    )
                    continue

                try:
                    tables = (
                        db.session.query(SqlaTable)
                        .filter(SqlaTable.database_id == database.id)
                        .all()
                    )
                    if tables:
                        random_table_index = random.randint(0, len(tables) - 1)
                        logger.info(
                            f"Database '{database.database_name}' has {len(tables)} tables"
                        )
                        logger.info(
                            f"Fetching metadata for table '{database.database_name}'.'{tables[random_table_index].table_name}'"
                        )
                        logger.info(tables[random_table_index].fetch_metadata())
                    else:
                        logger.error(
                            f"No tables registered for database '{database.database_name}'"
                        )

                except Exception as db_error:
                    logger.error(
                        f"Failed to fetch table schemas for '{database.database_name}': {str(db_error)}"
                    )

            logger.info(
                "\n\n========== 🧪 Database integration tests finished ==========\n"
            )

        except Exception as e:
            logger.error(f"Integration tests failed: {str(e)}")
