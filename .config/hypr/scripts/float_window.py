#!/usr/bin/env python3

import subprocess
import json
import time

# --- Configuration ---
BROWSER_CMD = ["flatpak", "run", "org.chromium.Chromium"]
#START_URL = "https://google.com" 
WINDOW_CLASS = "org.chromium.Chromium"

# Increased patient retries for slow Flatpak startup
MAX_RETRIES = 300 
POLL_INTERVAL = 0.1 

def run_hyprctl(command):
    """Executes a hyprctl command and returns the output."""
    try:
        result = subprocess.run(
            ['hyprctl'] + command.split(),
            capture_output=True,
            text=True,
            check=False
        )
        return result.stdout.strip()
    except FileNotFoundError:
        print("Error: hyprctl command not found. Is Hyprland running?")
        return None

def find_window_address():
    """Finds the address of the newest window matching the class."""
    
    start_time = time.time()
    for i in range(MAX_RETRIES):
        try:
            clients_output = run_hyprctl("clients -j")
            if not clients_output:
                time.sleep(POLL_INTERVAL)
                continue

            clients = json.loads(clients_output)
            
            # Filter for the target class
            matching_clients = [
                client for client in clients 
                if client.get('class') == WINDOW_CLASS
            ]

            if matching_clients:
                # Assuming the last entry in the list is the newest quick-search window.
                address = matching_clients[-1].get('address')
                
                # Retrieve the title right after finding the address
                title = matching_clients[-1].get('title')
                
                print(f"Window found in {time.time() - start_time:.2f}s. Initial Title: '{title}'")
                return address, title

        except json.JSONDecodeError:
            time.sleep(POLL_INTERVAL)
        except Exception as e:
            # We don't want to spam the console with warnings, just wait.
            time.sleep(POLL_INTERVAL)

    print(f"Error: Failed to find window address for {WINDOW_CLASS} after {MAX_RETRIES * POLL_INTERVAL}s.")
    return None, None

def main():
    # 1. Launch the browser in the background.
    subprocess.Popen(BROWSER_CMD)
    #subprocess.Popen(BROWSER_CMD + [START_URL])
    
    # 2. Find the window address AND its initial title for comparison.
    window_address, initial_title = find_window_address()
    
    if not window_address:
        # Exit if we couldn't find the window.
        return

    # If the initial title is empty or not found, we can't monitor changes, so exit.
    if not initial_title:
        print("Warning: Initial title was empty. Cannot monitor for changes.")
        return

    print("Quick Search window launched floating. Monitoring title changes...")

    # 3. Monitoring Loop: Check if the title has changed from the starting title.
    while True:
        clients_output = run_hyprctl("clients -j")
        if not clients_output:
            break 
            
        try:
            clients = json.loads(clients_output)
        except json.JSONDecodeError:
            time.sleep(POLL_INTERVAL)
            continue
        
        # Find the specific window data
        current_client = next((c for c in clients if c.get('address') == window_address), None)

        if not current_client:
            # Window was closed by the user, gracefully exit the script
            break 

        current_title = current_client.get('title', '')
        
        # --- FLEXIBLE LOGIC CHANGE ---
        # Trigger tiling if the current title is DIFFERENT from the original floating title.
        # This handles searches, navigating to other websites, etc.
        if current_title != initial_title:
            print(f"Title changed. New Title: {current_title}")
                
            # 4. Transition to Tiled/Normal Window
            run_hyprctl(f"dispatch focuswindow address:{window_address}")
            run_hyprctl(f"dispatch togglefloating") # Un-float it
            #run_hyprctl(f"dispatch fullscreen 0") # Ensure no full-screen state
            
            # Give Hyprland a moment to process the state change before the script exits
            time.sleep(0.1) 
            break

        time.sleep(POLL_INTERVAL)

if __name__ == "__main__":
    main()
