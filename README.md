1. Write the test
2. Make the test fail/error out
3. Write the simplest code that could make the test pass.
4. Refactor to improve.


Store Application
User
first name
last name
email

Cart
user_id
status

Item
name
inventory

Homework
Create a test in cart_spec for an instance method called `checkout`
- assign tht total of the cart to an attribute for the user called `total_spent`
- reduces the inventory for each item in the cart by 1
- changes the status of the cart from pending to submitted
