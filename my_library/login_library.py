# Importing the needed packages
import json
import os
from robot.api.deco import keyword
# This is to read the Json file under Utility
test_data_path = os.path.join(os.path.dirname(__file__),
                              "..",
                              "utility",
                              "locators.json")
with open(test_data_path, 'r') as file_path:
    data = json.load(file_path)

@keyword("Read Test Data")
def read_test_data():
    return data

# This is to read the URL from Json
@keyword("Read_URL")
def read_url():
    return data["URL"]["login_url"]

# This is to read the valid credentials
@keyword("Credentials")
def read_credentials():
    return data["Credentials"]["valid"][0]

# This is to read the locator for Username field
@keyword("Username_Field")
def read_username_locator():
    return data["Login_Element"]["username_field"][1]

# This is to read the locator for Password field
@keyword("Password_Field")
def read_password_locator():
    return data["Login_Element"]["password_field"][1]

# This is to read the locator for login button
@keyword("Click Login_Button")
def read_login_button_locator():
    return data["Login_Element"]["login_button"][1]

# This is to read the locator of error message
@keyword("Error Message")
def read_error_message_locator():
    return data["Error_Message"]["error_text"][1]

# This is to read the Invalid Credentials
@keyword("Invalid_Credentials")
def read_credentials():
    return data["Credentials"]["invalid"][0]




