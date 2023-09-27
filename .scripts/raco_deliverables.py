import json
import os
import requests
from typing import Dict, TextIO, Any


def get_deliverables(secrets: Dict[str, str]) -> dict[str, Any]:
    url = "https://api.fib.upc.edu/v2/jo/practiques/?format=json"
    header = {
        "Authorization": f"Bearer {secrets['access_token']}"
    }
    return requests.get(url, headers=header).json()


def refresh_token(secrets: dict, secrets_file: TextIO) -> None:
    url = "https://api.fib.upc.edu/v2/o/token"
    header = {
        "Content-Type": "application/x-www-form-urlencoded"
    }
    body = {
        "grant_type": "refresh_token",
        "refresh_token": secrets["refresh_token"],
        "client_id": secrets["client_id"],
        "client_secret": secrets["client_secret"],
        
    }
    data = requests.post(url, data=body, headers=header).json()
    secrets["access_token"] = data["access_token"]
    secrets["refresh_token"] = data["refresh_token"]
    json.dump(secrets, secrets_file)


def link(uri: str) -> str:
    return "{}\033\\".format(uri)


def show_deliverables(deliverables: Dict[str, Any]) -> None:
    course_code = {
        "CAI": 270220,
        "AA2": 270222,
        "AP3": 270213,
        "BDA": 270221,
        "EI": 270223,
        "TEOI": 270209,
        "VI": 270219,
    }

    base_course_url = "https://raco.fib.upc.edu/practiques/llista.jsp?espai="
    for deliverable in deliverables:
        course = deliverable["codi_asg"].split("-")[0]
        description = deliverable["titol"]
        date, time = deliverable["data_limit"].split("T")

        print(f"{course}: {description}")
        print(f"    Due on {date} at {time}")
        print(f"    {link(base_course_url + str(course_code[course]))}\n")


def main() -> None:
    folder = os.path.dirname(os.path.dirname(__file__))
    secrets_path = os.path.join(folder, ".secrets", "raco_deliverables.json")
    secrets_file = open(secrets_path, "r+")
    secrets = json.load(secrets_file)
    
    deliverables = get_deliverables(secrets)

    if "detail" in deliverables:
        refresh_token(secrets, secrets_file)
        deliverables = get_deliverables(secrets)

    show_deliverables(deliverables["results"])
    secrets_file.close()


if __name__ == "__main__":
    main()