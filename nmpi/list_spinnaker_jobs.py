"""
List all jobs that are SpiNNaker related in the NMPI queue.

Authentication parameters can be found in the config files on the server.
"""
import argparse
import requests

NMPI_URL = "https://nmpi.hbpneuromorphic.eu/api/v2/queue/"

parser = argparse.ArgumentParser()
parser.add_argument("username", help="The username to authenticate with")
parser.add_argument("token", help="The token to authenticate with")

args = parser.parse_args()
headers = {
    "Authorization": "ApiKey {}:{}".format(args.username, args.token),
    "Content-Type": "application/json"
}

response = requests.get(NMPI_URL, headers=headers)
job_list = response.json()

other = list()
for job in job_list["objects"]:
    if "SPINNAKER" in job["hardware_platform"].upper():
        print("{}: {}: {}".format(
            job["hardware_platform"], job["id"], job["status"]))
    else:
        other.append(job)

print("\nOther jobs:")
for job in other:
    print("{}: {}: {}".format(
        job["hardware_platform"], job["id"], job["status"]))
