#Importing all the needed packages
import json
import os
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.ui import Select
from selenium.webdriver.support.wait import WebDriverWait

# This is to read the Json file under Utility
test_data_path = os.path.join(os.path.dirname(__file__),
                              "..",
                              "utility",
                              "locators.json")
with open(test_data_path, 'r') as file_path:
    data = json.load(file_path)
  
# This is the User-Defined Keyword that reads the valid user credentials
@keyword("Credentials")
def read_credentials():
    return data["Credentials"]["valid"][0]
  
# This is the User-Defined Keyword that reads the locator of drop down element
@keyword("Drop Down")
def read_drop_down():
    return data["Products"]["select"][1]
  
# This is the User-Defined Keyword that reads the locator of Add to cart element
@keyword("Add Cart")
def read_add_cart():
    return data["Cart"]["add_element"][1]
  
# This is the User-Defined Keyword that reads the locator that selects the first product in the particular filter
@keyword("Actual Item Name")
def read_item_name():
    return data["Item_Name"]["item"][1]
  
# This is the User-Defined Keyword that reads the locator to click on Cart Icon
@keyword("Click On Cart")
def read_cart_locator():
    return data["Cart_link"]["cart"][1]
  
# This is the User-Defined Keyword that reads the locator of the selected product in the cart
@keyword("Cart Item Name")
def read_cart_item_name():
    return data["Cart_Item"]["cart_item"][1]
  
# This is the User-Defined Keyword that reads the locator to click on Check Out Button
@keyword("Check Out")
def read_check_out_locator():
    return data["Check_Out"]["check_out"][1]

# This is the User-Defined Keyword that helps to do the following steps
@keyword("Add Multiple Products And Verify Cart")
def add_multiple_products():
    sel = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = sel.driver
    wait=WebDriverWait(driver,20)

    selected_items=[]
    # 1. Click on the Drop_Down Element
    drop_down = Select(driver.find_element(By.XPATH, "//select[@class='product_sort_container']"))
    options=len(drop_down.options)
    # 2. Select the filter by length of the number of filters present by Value and append them to the selected list
    for index in range(options):
        drop_down = Select(driver.find_element(By.XPATH, "//select[@class='product_sort_container']"))
        value = drop_down.options[index].get_attribute("value")
        drop_down.select_by_value(value)
        # 3. Then after selecting Each filter then Add the first product from that list
        item_element=wait.until(
            expected_conditions.visibility_of_element_located(
                (By.XPATH,"(//div[@class='inventory_list']//div[@class='inventory_item']//div[1]//div[@class='inventory_item_name '])[1]")
            )
        )
        item_txt=item_element.text
        selected_items.append(item_txt)
        # To click on Add Cart on the First Product
        click_add_cart=wait.until(
            expected_conditions.element_to_be_clickable(
                (By.XPATH,"(//button[@class='btn btn_primary btn_small btn_inventory '])[1]")
            )
        )
        click_add_cart.click()
    # 4. Click on the Cart Icon
    click_on_cart=driver.find_element(By.XPATH,"//a[@class='shopping_cart_link']")
    click_on_cart.click()
    # 5. Locates the products name in the cart and append them to the added list
    cart_items=wait.until(
            expected_conditions.visibility_of_all_elements_located(
                (By.XPATH,"//div[@class='inventory_item_name']")
            )
    )
    added_items=[item.text for item in cart_items]
    # 6. Compare both the list and if the list does not match then it raises exception else the The list will be printed in the report
    if sorted(selected_items) != sorted(added_items):
        raise AssertionError(
            f"Cart items do not match!\nExpected: {selected_items}\nActual: {added_items}"
        )
    else:
        print(f"Cart Items Matches\nExpected: {selected_items}\nActual: {added_items}")























