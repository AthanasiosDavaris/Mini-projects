import random
import datetime

#Initialising the variables
dn = ['morning', 'afternoon'] #Time zones that the gym is open
timeDay = [9,10,11,12] #Morning working hours of the gym
timeAfternoon = [2,3,4,5,6,7,8,9,10] #Afternoon working hours of the gym
timeSaturday = [2,3,4,5,6,7,8] #Special saturday hours
today = datetime.datetime.today() #Variable that stores the date today

#Condition that checks if the day is friday (The program is meant to be used the day before)
if today.weekday() == 4:
  print("Tomorrow is Saturday so go at " + str(random.choice(timeSaturday)))
else:
  choice = random.choice(dn) 
  print("Go in the " + choice + " and at " + (str(random.choice(timeDay)) if "morning" in choice else str(random.choice(timeAfternoon))))