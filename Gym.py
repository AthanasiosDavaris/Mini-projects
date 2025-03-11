import random
import datetime

dn = ['morning', 'afternoon']
timeDay = [9,10,11,12]
timeAfternoon = [2,3,4,5,6,7,8,9,10]
timeSaturday = [2,3,4,5,6,7,8]
today = datetime.datetime.today()

if today.weekday() == 4:
  print("Tomorrow is Saturday so go at " + str(random.choice(timeSaturday)))
else:
  choice = random.choice(dn) 
  print("Go in the " + choice + " and at " + (str(random.choice(timeDay)) if "morning" in choice else str(random.choice(timeAfternoon))))