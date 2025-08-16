# Robot-Framework_Task_20
This repository includes a Robot Framework test suites for 
1. Verifying Valid and Invalid User Login and Error Message.
2. Automating the product selection.
3. Cart verification workflow on [SauceDemo](https://www.saucedemo.com/).
4. It adds multiple sorted products to the cart and ensures they are correctly added.

## 🛠️ Testing Tools & Frameworks Used
- **Robot Framework** – Open-source automation framework for acceptance testing and RPA  
- **SeleniumLibrary** – Web testing library for Robot Framework  
- **Python** – Scripting language used for integration and custom keywords  
- **Browser** – Chrome browser for executing tests  
- **JSON** – Used for storing test data (credentials, product details, etc.)
  
## Test Cases 
- **Test Case 1**: Login with valid credentials (username: `standard_user`, password: `secret_sauce`) and verify that the user lands on the products page.  
- **Test Case 2**: Attempt to login with invalid credentials and verify that an appropriate error message is displayed.  
- **Test Case 3**: After logging in with valid credentials, add a product to the cart and verify that the product is correctly listed in the cart.  
- **Test Case 4**: Log in with valid credentials, add multiple products to the cart, and proceed to the checkout page. Verify that the correct items and quantities are listed in the checkout summary.

### **To run the Tests**
<pre> <code>robot tests </code> </pre>

