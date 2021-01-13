import requests
from datetime import date, timedelta, datetime
import os

now = datetime.now().strftime("%Y-%m-%d")

link = 'https://api.track.toggl.com/reports/api/v2/details?user_agent={user_agent}&workspace_id={workspace_id}&user_ids={user_ids}&since={since}'

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

total = r.json()['total_grand']

total_in_hours = total / (1000 * 60 * 60)

hours = int(total_in_hours)
minutes = (total_in_hours * 60) % 60

print("Today %dh:%02dm/6h" % (hours, minutes))
