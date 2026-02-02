#!/usr/bin/env python3

"""
Script to test access denied for Superset dashboards
- Authenticates with Superset credentials to retrieve dashboard list
- Curls all dashboard URLs without credentials and verifies access is denied

Usage: python test-access-denied.py <base_url> <username> <password> <upptime>
"""

import sys
import requests
from typing import Dict, List, Tuple


def parse_arguments() -> Tuple[str, str, str, str]:
    """
    Parse command line arguments.
    
    Returns:
        Tuple of (superset_url, username, password, upptime_value)
    
    Raises:
        SystemExit: If required arguments are missing
    """
    if len(sys.argv) != 5:
        print("Usage: python test-access-denied.py <base_url> <username> <password> <upptime>")
        print("  base_url: Superset base URL")
        print("  username: Database username")
        print("  password: Database password")
        print("  upptime: Value for upptime header")
        sys.exit(1)

    superset_url = sys.argv[1].rstrip('/')
    username = sys.argv[2]
    password = sys.argv[3]
    upptime_value = sys.argv[4]
    
    return superset_url, username, password, upptime_value


def authenticate(session: requests.Session, superset_url: str, username: str, password: str) -> str:
    """
    Authenticate with Superset and get access token.
    
    Args:
        session: Requests session object
        superset_url: Base URL of Superset instance
        username: Database username
        password: Database password
    
    Returns:
        Access token string
    
    Raises:
        SystemExit: If authentication fails
    """
    print("Authenticating with Superset...")
    
    try:
        login_response = session.post(
            f"{superset_url}/api/v1/security/login",
            headers={"Content-Type": "application/json"},
            json={
                "username": username,
                "password": password,
                "provider": "db",
                "refresh": True
            }
        )

        login_response.raise_for_status()
        access_token = login_response.json().get("access_token")
        
        if not access_token:
            print("Error: Failed to authenticate. Check credentials.")
            sys.exit(1)
            
        print("Authentication successful")
        return access_token
        
    except requests.RequestException as e:
        print("Error: Failed to authenticate")
        sys.exit(1)


def get_all_dashboards(session: requests.Session, superset_url: str, access_token: str) -> List[Dict]:
    """
    Retrieve all dashboards from Superset.
    
    Args:
        session: Requests session object
        superset_url: Base URL of Superset instance
        access_token: Access token from authentication
    
    Returns:
        List of dashboard dictionaries
    
    Raises:
        SystemExit: If dashboard retrieval fails
    """
    print("Fetching dashboards...")
    
    try:
        dashboards_response = session.get(
            f"{superset_url}/api/v1/dashboard/",
            headers={
                "Authorization": f"Bearer {access_token}",
                "Content-Type": "application/json"
            }
        )
        dashboards_response.raise_for_status()
        dashboards_data = dashboards_response.json()
        
        dashboard_count = dashboards_data.get("count", 0)
        print(f"Found {dashboard_count} dashboards")
        
        return dashboards_data.get("result", [])
        
    except requests.RequestException as e:
        print("Error: Failed to retrieve dashboards")
        sys.exit(1)


def test_dashboard_access(superset_url: str, dashboard_id: int, dashboard_slug: str, upptime_value: str) -> bool:
    """
    Test that a dashboard URL returns 403 or similar access denied response without credentials.
    
    Args:
        superset_url: Base URL of Superset instance
        dashboard_id: ID of the dashboard
        dashboard_slug: Slug of the dashboard
        upptime_value: Value for upptime header
    
    Returns:
        True if access is denied (expected), False if access is allowed (unexpected)
    """
    dashboard_url = f"{superset_url}/d/{dashboard_slug}/{dashboard_id}/"
    
    try:
        # Test without credentials
        response = requests.get(dashboard_url, timeout=10, allow_redirects=False, headers={"upptime": upptime_value})
        http_code = str(response.status_code)
        
        # Expected: any non-2xx status code (access denied)
        if not http_code.startswith("2"):
            print(f"✓ Dashboard {dashboard_id} correctly returns {http_code}")
            return True
        else:
            print(f"✗ Dashboard {dashboard_id} returned {http_code} (expected non-2xx status code)")
            return False
            
    except requests.Timeout:
        print(f"✗ Dashboard {dashboard_id} request timed out")
        return False
    except Exception as e:
        print(f"✗ Dashboard {dashboard_id} test failed: {str(e)}")
        return False


def main():
    """
    Main function to orchestrate access denied testing.
    """
    # Parse command line arguments
    superset_url, username, password, upptime_value = parse_arguments()
    
    # Create a session to maintain cookies
    session = requests.Session()
    
    # Add upptime header to all requests
    # This allows the request through the WAF Canada-only geolocation rule
    session.headers.update({"upptime": upptime_value})
    
    # Authenticate and get access token
    access_token = authenticate(session, superset_url, username, password)
    
    # Get all dashboards
    dashboards = get_all_dashboards(session, superset_url, access_token)
    
    if not dashboards:
        print("No dashboards found")
        return
    
    print()
    print(f"Testing access denied on {len(dashboards)} dashboards...")
    print()
    
    failed = []
    
    # Test each dashboard
    for dashboard in dashboards:
        dashboard_id = dashboard.get("id")
        dashboard_slug = dashboard.get("slug", "dashboard")
        
        if not test_dashboard_access(superset_url, dashboard_id, dashboard_slug, upptime_value):
            failed.append(dashboard_id)
    
    print()
    print(f"Access denied test results: {len(dashboards) - len(failed)} passed, {len(failed)} failed")
    
    if failed:
        print(f"Failed dashboard IDs: {failed}")
        print("Error: Some dashboards were accessible without credentials")
        sys.exit(1)
    else:
        print("Success: All dashboards correctly deny access without credentials")


if __name__ == "__main__":
    main()
