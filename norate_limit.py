
import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning
import json

values = {'username': 'user', 'password': 'pass'}

def get_data(url):
    requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

    response = requests.post(url, values, verify = False)
    if response.status_code == 200:
        data = response.json()
        print(data)
        return data
    else:
        print(response.text)
        print(response.status_code)

for i in range(5000):
    base_url = "https://redacted.com/auriga/api/auth/token"
    data = get_data(base_url)


print("I have just sent 5000 request with no rate limiting in place,same status code && same response ")
