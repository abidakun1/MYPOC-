
import sys
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from requests.exceptions import ConnectionError
import requests

G = "\033[0;32m"
R = "\033[0;31m"

if len(sys.argv) != 2:
    print(f"Usage: python3 hstv.py example.com ")
    exit(1)

url = sys.argv[1]

print("CHECK: HTTP STRICT TRANSPORT VULNERABILITY")

try:
    requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
    response = requests.get(url, verify=False)
    if "strict-transport-security" in response.headers:
        print(f"{R}NOT VULNERABLE -: Http Strict TS present")
    else:
        print(f"{G}VULNERABLE -: Http Strict TS absent")
except ConnectionError:
    print("Error connecting to the server")
