import smtplib

my_email = "test@gmail.com"
password = "test123"

connection = smtplib.SMTP("smtp.gmail.com", 587)
connection.starttls()
connection.login(user=my_email, password=password)

connection.sendmail(from_addr=my_email,
                    to_addrs="reciepentemail@gmail.com", msg="Hello World")

connection.close()