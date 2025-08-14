*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/multiple_products_keywords.robot
Library    ../my_library/login_library.py
Library    ../my_library/product_library.py
Suite Setup    Launch Browser
Suite Teardown    Close The Browser
Documentation    This test suite verifies login functionality, Then Add Products, Verify Products and Checkout for SwagLabs app.


*** Test Cases ***
Add A Product And Verify The Product
    [Documentation]    This Test Verifies the Multiple Product Adding, Verifying and Checkout.
    Navigate To Application
    Input Credentials
    Click Login
    Capture Page Screenshot
    Dashboard Validation
    Add Multiple Products And Verify Cart
    Check Out
    Close The Browser