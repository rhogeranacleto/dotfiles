import requests
import os
from datetime import datetime
import pytz

link = 'https://www.toggl.com/api/v8/time_entries/current'
script_dir = os.path.dirname(__file__)
file = open(os.path.join(script_dir, 'token.txt'))
token = file.read().replace('/n', '')
file.close()

r = requests.get(link, auth=(token.strip(), 'api_token'))

response = r.json()['data']

if response == None:
  print('---')
  exit()

start_date_string = response['start']
start = datetime.fromisoformat(start_date_string)
now = datetime.now(pytz.utc)
seconds = (now - start).total_seconds()

description = response['description']

print('%ih:%im %s' % (seconds / 3600, seconds % 3600/60, description))