import string
import random

password_length = int(input("Please give me the password length: "))

password = "".join(random.choices(string.ascii_uppercase+string.digits+string.punctuation, k=password_length))
print(password)