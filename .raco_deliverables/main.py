import json
import os
import requests

def main():
    folder = os.path.dirname(__file__)
    secrets_path = os.path.join(folder, "secrets.json")
    secrets_file = open(secrets_path, "r+")
    secrets = json.load(secrets_file)
    
    url = "https://api.fib.upc.edu/v2/jo/practiques/?format=json"
    header = {
        "Authorization": f"Bearer {secrets['access_token']}"
    }
    data = requests.get(url, headers=header).json()

    print(data["results"])

    # json.dump(secrets, secrets_file)

if __name__ == "__main__":
    main()