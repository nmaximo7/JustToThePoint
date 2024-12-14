import json
import pyperclip
import datetime
import subprocess
from difflib import get_close_matches

def process_replacement(user_input, replacement):
    """
    Process the replacement string by handling dynamic placeholders.

    Args:
        user_input (str): The trigger entered by the user.
        replacement (str): The replacement string from the JSON.

    Returns:
        str: The processed replacement string.
    """
    if "{{" in replacement and "}}" in replacement:
        # Handle known placeholders
        if user_input == ":date":
            already_process_replacement = datetime.datetime.now().strftime("%d/%m/%y")
        elif user_input == ":time":
            already_process_replacement = datetime.datetime.now().strftime("%H:%M")
        elif user_input == ":weather":
            try:
                already_process_replacement = subprocess.check_output(
                    ["curl", "http://wttr.in/Malaga"],
                    stderr=subprocess.DEVNULL
                ).decode().strip()
            except Exception as e:
                already_process_replacement = "Weather service unavailable."
        else:
            already_process_replacement = replacement
    else:
        already_process_replacement = replacement

    return already_process_replacement

def load_triggers(json_file):
    """
    Load triggers and replacements from a JSON file.

    Args:
        json_file (str): Path to the JSON file.

    Returns:
        dict: Dictionary mapping triggers to replacements.
    """
    try:
        with open(json_file, 'r', encoding='utf-8') as f:
            triggers = json.load(f)
        return triggers
    except FileNotFoundError:
        print(f"Error: The file {json_file} was not found.")
        return {}
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON: {e}")
        return {}

def main():
    json_file = '../Espanso/myespanso.json'  # Ensure this path is correct
    triggers = load_triggers(json_file)

    if not triggers:
        print("No triggers loaded. Exiting.")
        return

    print("Espanso Replacer is running. Type your triggers below:")
    print("Press Ctrl+C to exit.\n")

    try:
        while True:
            user_input = input("Enter trigger: ").strip()
            trigger_keys = triggers.keys()

            # Get the closest match with a certain similarity threshold (cutoff)
            closest_matches = get_close_matches(user_input, trigger_keys, n=1, cutoff=0.6)

            if closest_matches:
                closest_trigger = closest_matches[0]
                replacement = triggers[closest_trigger]
                print(f"{replacement}")
                already_process_replacement =  process_replacement(user_input, replacement)
                print(f"Replacement: {already_process_replacement}\n")
                pyperclip.copy(f"{already_process_replacement}")

            else:
                print("Trigger not found.\n")
    except KeyboardInterrupt:
        print("\nExiting Espanso Replacer. Goodbye!")

if __name__ == "__main__":
    main()