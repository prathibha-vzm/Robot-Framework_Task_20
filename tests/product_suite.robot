*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/product_keywords.robot
Library    ../my_library/login_library.py
Library    ../my_library/product_library.py
Suite Setup    Launch Browser
Suite Teardown    Close The Browser
Documentation    This test suite verifies login functionality and Add a Products and Verify for Swag labs app.

*** Test Cases ***
Add A Product And Verify The Product
    [Documentation]    This Test Verifies by adding a product and verify the same prodcut is added in cart.
    Navigate To Application
    Input Credentials
    Click Login
    Capture Page Screenshot
    Dashboard Validation
    ${ITEMS}=    Add A Product To Cart
    Verify The Product In Cart    ${ITEMS}
    Close The Browser