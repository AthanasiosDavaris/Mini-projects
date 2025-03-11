import random

#Welcome message
print("Welcome to my guessing game (by Prince of Aces)")

#Initialising the variables and generating the random number
lowest_num = 1
highest_num = 10
ran_num = random.randint(lowest_num, highest_num)
lives = 3

#Game start!
while lives > 0:

  #Guess input
  print(f"You have {lives} lives remaining")
  guess = int(input(f"guess a number between {lowest_num} and {highest_num}: "))

  #Condition that checks if the guess is right
  if guess == ran_num:
    #Win message
    print("Congrats! You've Won")
    exit()
  else:
    #Failed try message
    print("Fail...")
  lives -= 1

#Loss message
print("You've ran out of lives")
print(f"The number was {ran_num}")