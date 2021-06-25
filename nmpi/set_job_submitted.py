"""
Set a job from the queue to "Error" status.

Authentication parameters can be found in the config files on the server.
"""
import argparse
import requests

NMPI_URL = "https://nmpi.hbpneuromorphic.eu/api/v2/queue/{}"
NMPI_LOG_URL = "https://nmpi.hbpneuromorphic.eu/api/v2/log/{}"

parser = argparse.ArgumentParser()
parser.add_argument("job", help="The Job ID")
parser.add_argument("username", help="The username to authenticate with")
parser.add_argument("token", help="The token to authenticate with")

args = parser.parse_args()
headers = {
    "Authorization": "ApiKey {}:{}".format(args.username, args.token),
    "Content-Type": "application/json"
}

job_url = NMPI_URL.format(args.job)
response = requests.get(job_url, headers=headers)
job = response.json()
print(job)

job["status"] = "submitted"
put_response = requests.put(job_url, json=job, headers=headers)
print("Job update response:", put_response)
