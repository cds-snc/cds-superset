#!/usr/bin/env python3

"""
Script to manage cache-warmup tags on Superset dashboards
- Published dashboards get the cache-warmup tag added
- Draft dashboards get the cache-warmup tag removed

Usage: python manage-cache-warmup-tags.py <base_url> <username> <password>
"""

import sys
import requests
import json
from typing import Dict, List, Optional, Tuple


def parse_arguments() -> Tuple[str, str, str]:
    """
    Parse command line arguments.
    
    Returns:
        Tuple of (superset_url, username, password)
    
    Raises:
        SystemExit: If required arguments are missing
    """
    if len(sys.argv) != 4:
        print("Usage: python manage-cache-warmup-tags.py <base_url> <username> <password>")
        print("  base_url: Superset base URL")
        print("  username: Database username")
        print("  password: Database password")
        sys.exit(1)

    superset_url = sys.argv[1].rstrip('/')
    username = sys.argv[2]
    password = sys.argv[3]
    
    return superset_url, username, password


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


def get_csrf_token(session: requests.Session, superset_url: str, access_token: str) -> str:
    """
    Retrieve CSRF token from Superset.
    
    Args:
        session: Requests session object
        superset_url: Base URL of Superset instance
        access_token: Access token from authentication
    
    Returns:
        CSRF token string
    
    Raises:
        SystemExit: If CSRF token retrieval fails
    """
    print("Fetching CSRF token...")
    
    try:
        csrf_response = session.get(
            f"{superset_url}/api/v1/security/csrf_token/",
            headers={"Authorization": f"Bearer {access_token}"}
        )
        csrf_response.raise_for_status()
        csrf_token = csrf_response.json().get("result")
        
        if not csrf_token:
            print("Error: Failed to retrieve CSRF token")
            sys.exit(1)
            
        print("CSRF token retrieved")
        return csrf_token
        
    except requests.RequestException as e:
        print("Error: Failed to retrieve CSRF token")
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


def get_dashboard_details(
    session: requests.Session, 
    superset_url: str, 
    access_token: str, 
    dashboard_id: int
) -> Optional[Dict]:
    """
    Get detailed information for a specific dashboard.
    
    Args:
        session: Requests session object
        superset_url: Base URL of Superset instance
        access_token: Access token from authentication
        dashboard_id: ID of the dashboard
    
    Returns:
        Dashboard detail dictionary or None if retrieval fails
    """
    try:
        dashboard_detail_response = session.get(
            f"{superset_url}/api/v1/dashboard/{dashboard_id}",
            headers={
                "Authorization": f"Bearer {access_token}",
                "Content-Type": "application/json"
            }
        )
        dashboard_detail_response.raise_for_status()
        return dashboard_detail_response.json().get("result", {})
        
    except requests.RequestException as e:
        print(f"⚠ Warning: Failed to retrieve dashboard details for ID {dashboard_id}")
        return None


def has_cache_warmup_tag(tags: List[Dict], tag_name: str) -> bool:
    """
    Check if cache-warmup tag exists in the list of tags.
    
    Args:
        tags: List of tag dictionaries
        tag_name: Name of the tag to check for
    
    Returns:
        True if tag exists, False otherwise
    """
    return any(tag.get("name") == tag_name for tag in tags)


def add_tag(
    session: requests.Session,
    superset_url: str,
    access_token: str,
    csrf_token: str,
    dashboard_id: int,
    tag_name: str,
    dashboard_object_type: str
) -> bool:
    """
    Add cache-warmup tag to a dashboard.
    
    Args:
        session: Requests session object
        superset_url: Base URL of Superset instance
        access_token: Access token from authentication
        csrf_token: CSRF token
        dashboard_id: ID of the dashboard
        tag_name: Name of the tag to add
        dashboard_object_type: Type of dashboard object
    
    Returns:
        True if successful, False otherwise
    """
    print("Action: Adding cache-warmup tag...")
    
    try:
        add_response = session.post(
            f"{superset_url}/api/v1/tag/{dashboard_object_type}/{dashboard_id}",
            headers={
                "Authorization": f"Bearer {access_token}",
                "X-CSRFToken": csrf_token,
                "Content-Type": "application/json",
                "Referer": superset_url
            },
            json={"properties": {"tags": [tag_name]}}
        )
        
        add_response.raise_for_status()
        
        if add_response.status_code == 201:
            print("✓ Tag added successfully")
            return True
        else:
            print("⚠ Warning: Failed to add tag")
            return False
            
    except requests.RequestException as e:
        print("⚠ Warning: Failed to add tag")
        return False


def remove_tag(
    session: requests.Session,
    superset_url: str,
    access_token: str,
    csrf_token: str,
    dashboard_id: int,
    tag_name: str,
    dashboard_object_type: str
) -> bool:
    """
    Remove cache-warmup tag from a dashboard.
    
    Args:
        session: Requests session object
        superset_url: Base URL of Superset instance
        access_token: Access token from authentication
        csrf_token: CSRF token
        dashboard_id: ID of the dashboard
        tag_name: Name of the tag to remove
        dashboard_object_type: Type of dashboard object
    
    Returns:
        True if successful, False otherwise
    """
    print("Action: Removing cache-warmup tag...")
    
    try:
        remove_response = session.delete(
            f"{superset_url}/api/v1/tag/{dashboard_object_type}/{dashboard_id}/{tag_name}",
            headers={
                "Authorization": f"Bearer {access_token}",
                "X-CSRFToken": csrf_token,
                "Content-Type": "application/json",
                "Referer": superset_url
            }
        )
        remove_response.raise_for_status()
        
        response_text = remove_response.text
        if (response_text and json.loads(response_text).get("message") == "OK") or not response_text:
            print("✓ Tag removed successfully")
            return True
        else:
            print("⚠ Warning: Failed to remove tag")
            return False
            
    except requests.RequestException as e:
        print("⚠ Warning: Failed to remove tag")
        return False


def process_dashboard(
    session: requests.Session,
    superset_url: str,
    access_token: str,
    csrf_token: str,
    dashboard: Dict,
    tag_name: str,
    dashboard_object_type: str
) -> None:
    """
    Process a single dashboard to add or remove cache-warmup tag based on published status.
    
    Args:
        session: Requests session object
        superset_url: Base URL of Superset instance
        access_token: Access token from authentication
        csrf_token: CSRF token
        dashboard: Dashboard dictionary
        tag_name: Name of the tag to manage
        dashboard_object_type: Type of dashboard object
    """
    dashboard_id = dashboard.get("id")
    is_published = dashboard.get("published", False)
    
    # Get dashboard details to check current tags
    dashboard_detail = get_dashboard_details(session, superset_url, access_token, dashboard_id)
    
    if dashboard_detail is None:
        return
    
    current_tags = dashboard_detail.get("tags", [])
    has_tag = has_cache_warmup_tag(current_tags, tag_name)
    
    print()
    print(f"Dashboard ID: {dashboard_id}")
    print(f"Published: {is_published}")
    print(f"Has cache-warmup tag: {has_tag}")
    
    # Determine action needed
    if is_published:
        if not has_tag:
            add_tag(session, superset_url, access_token, csrf_token, dashboard_id, tag_name, dashboard_object_type)
        else:
            print("Action: None (tag already present)")
    else:
        # Draft dashboard
        if has_tag:
            remove_tag(session, superset_url, access_token, csrf_token, dashboard_id, tag_name, dashboard_object_type)
        else:
            print("Action: None (tag not present)")


def main():
    """
    Main function to orchestrate cache-warmup tag management.
    """
    # Parse command line arguments
    superset_url, username, password = parse_arguments()
    
    # Constants
    tag_name = "cache-warmup"
    dashboard_object_type = "3"
    
    # Create a session to maintain cookies
    session = requests.Session()
    
    # Authenticate and get tokens
    access_token = authenticate(session, superset_url, username, password)
    csrf_token = get_csrf_token(session, superset_url, access_token)
    
    # Get all dashboards
    dashboards = get_all_dashboards(session, superset_url, access_token)
    
    print("Processing dashboards...")
    
    # Process each dashboard
    for dashboard in dashboards:
        process_dashboard(
            session,
            superset_url,
            access_token,
            csrf_token,
            dashboard,
            tag_name,
            dashboard_object_type
        )
    
    print()
    print("Dashboard cache-warmup tag management completed")


if __name__ == "__main__":
    main()
