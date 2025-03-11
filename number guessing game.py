import random

print("Welcome to my guessing game (by Prince of Aces)")

lowest_num = 1
highest_num = 10
ran_num = random.randint(lowest_num, highest_num)
lives = 3
while lives > 0:
  print(f"You have {lives} lives remaining")
  guess = int(input(f"guess a number between {lowest_num} and {highest_num}: "))
  if guess == ran_num:
    print("Congrats! You've Won")
    exit()
  else:
    print("Fail...")
  lives -= 1
print("You've ran out of lives")
print(f"The number was {ran_num}")