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


def main():
    # Check if all required arguments are provided
    if len(sys.argv) != 4:
        print("Usage: python manage-cache-warmup-tags.py <base_url> <username> <password>")
        print("  base_url: Superset base URL")
        print("  username: Database username")
        print("  password: Database password")
        sys.exit(1)

    superset_url = sys.argv[1].rstrip('/')
    username = sys.argv[2]
    password = sys.argv[3]
    tag_name = "cache-warmup"
    dashboard_object_type = "3"

    # Create a session to maintain cookies
    session = requests.Session()

    print("Authenticating with Superset...")

    # Login and get access token
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
            print(f"Response: {login_response.text}")
            sys.exit(1)
            
        print("Authentication successful")
        
    except requests.RequestException as e:
        print(f"Error: Failed to authenticate: {e}")
        sys.exit(1)

    # Get CSRF token
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
        
    except requests.RequestException as e:
        print(f"Error: Failed to retrieve CSRF token: {e}")
        sys.exit(1)

    # Retrieve all dashboards
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
        
        dashboards = dashboards_data.get("result", [])
        
    except requests.RequestException as e:
        print(f"Error: Failed to retrieve dashboards: {e}")
        sys.exit(1)

    print("Processing dashboards...")

    # Process each dashboard
    for dashboard in dashboards:
        dashboard_id = dashboard.get("id")
        is_published = dashboard.get("published", False)
        
        # Get dashboard details to check current tags
        try:
            dashboard_detail_response = session.get(
                f"{superset_url}/api/v1/dashboard/{dashboard_id}",
                headers={
                    "Authorization": f"Bearer {access_token}",
                    "Content-Type": "application/json"
                }
            )
            dashboard_detail_response.raise_for_status()
            dashboard_detail = dashboard_detail_response.json().get("result", {})
            
            dashboard_title = dashboard_detail.get("dashboard_title", "Unknown")
            current_tags = dashboard_detail.get("tags", [])
            
            # Check if cache-warmup tag exists
            has_tag = any(tag.get("name") == tag_name for tag in current_tags)
            
            print()
            print(f"Dashboard ID: {dashboard_id}")
            print(f"Published: {is_published}")
            print(f"Has cache-warmup tag: {has_tag}")
            
            # Determine action needed
            if is_published:
                if not has_tag:
                    print("Action: Adding cache-warmup tag...")
                    
                    # Add the tag
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
                        else:
                            print("⚠ Warning: Failed to add tag")
                            print(f"Response: {add_response.text}")
                            
                    except requests.RequestException as e:
                        print(f"⚠ Warning: Failed to add tag: {e}")
                        if hasattr(e, 'response') and e.response is not None:
                            print(f"Error response: {e.response.text}")
                else:
                    print("Action: None (tag already present)")
            else:
                # Draft dashboard
                if has_tag:
                    print("Action: Removing cache-warmup tag...")
                    
                    # Remove the tag
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
                        else:
                            print("⚠ Warning: Failed to remove tag")
                            print(f"Response: {response_text}")
                            
                    except requests.RequestException as e:
                        print(f"⚠ Warning: Failed to remove tag: {e}")
                else:
                    print("Action: None (tag not present)")
                    
        except requests.RequestException as e:
            print(f"⚠ Warning: Failed to retrieve dashboard details for ID {dashboard_id}: {e}")
            continue

    print()
    print("Dashboard cache-warmup tag management completed")


if __name__ == "__main__":
    main()
