import logging
from superset.security import SupersetSecurityManager


class SsoSecurityManager(SupersetSecurityManager):
    def oauth_user_info(self, provider, response=None):
        """
        Override to fetch user info from different endpoints based on the provider.
        This allows us to support both Zitadel and Google as OAuth providers.
        """
        logging.debug("Oauth2 provider: {0}.".format(provider))
        if provider == "zitadel":
            user = (
                self.appbuilder.sm.oauth_remotes[provider]
                .get("oidc/v1/userinfo")
                .json()
            )
            logging.debug("user_data: {0}".format(user))
            return {
                "name": user["name"],
                "email": user["email"],
                "email_verified": user.get("email_verified", False),
                "id": user["preferred_username"],
                "username": user["preferred_username"],
                "first_name": user["given_name"],
                "last_name": user["family_name"],
            }
        elif provider == "google":
            user = self.appbuilder.sm.oauth_remotes[provider].get("userinfo").json()
            logging.debug("user_data: {0}".format(user))
            return {
                "name": user["name"],
                "email": user["email"],
                "email_verified": user.get("verified_email", False),
                "id": user["id"],
                "username": user["id"],
                "first_name": user["given_name"],
                "last_name": user["family_name"],
            }

    def auth_user_oauth(self, userinfo):
        """
        Override to link OAuth accounts by email instead of creating separate accounts
        for each OAuth provider.

        This allows users to login with either Google or Zitadel and access the same account
        if their email matches.

        Security: Requires verified email from OAuth provider before allowing login.
        """
        email = userinfo.get("email")
        if not email:
            logging.warning("OAuth login attempted without email")
            return None

        # Verify that the email is verified by the OAuth provider
        email_verified = userinfo.get("email_verified", False)
        if not email_verified:
            logging.warning(f"OAuth login attempted with unverified email: {email}")
            return None

        user = self.find_user(email=email)
        if user:
            logging.debug(f"Existing user found by email: {email}")
            self.update_user_auth_stat(user)
            return user

        logging.debug(f"Creating new user for email: {email}")
        return self.add_user(
            username=userinfo.get("username", email),
            first_name=userinfo.get("first_name", ""),
            last_name=userinfo.get("last_name", ""),
            email=email,
            role=self.find_role(self.auth_user_registration_role),
        )
