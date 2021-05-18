import requests
from datetime import date, timedelta, datetime
import os
import pytz

now = datetime.now().strftime("%Y-%m-%d")

link = 'https://api.track.toggl.com/reports/api/v2/details?user_agent={user_agent}&workspace_id={workspace_id}&user_ids={user_ids}&since={since}'
link_current = 'https://www.toggl.com/api/v8/time_entries/current'

script_dir = os.path.dirname(__file__)
file = open(os.path.join(script_dir, 'token.txt'))
token = file.read().replace('/n', '')
file.close()

r = requests.get(link.format(
  user_agent='rhoger.anacleto@magrathelabs.com',
  workspace_id='1954462',
  user_ids='4806242',
  since=now
), auth=(token.strip(), 'api_token'))
current_response = requests.get(link_current, auth=(token.strip(), 'api_token'))

total = r.json()['total_grand']

current_data = current_response.json()['data']

if (current_data != None):
  start_date_string = current_data['start']
  start = datetime.fromisoformat(start_date_string)
  now = datetime.now(pytz.utc)
  hours = (now - start).total_seconds() / 3600
else:
  hours = 0

total_in_hours = ((total or 0) / (1000 * 60 * 60)) + hours

hours = int(total_in_hours)
minutes = (total_in_hours * 60) % 60

print("Today %dh:%02dm/6h" % (hours, minutes))
