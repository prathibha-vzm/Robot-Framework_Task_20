*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/valid_login_keywords.robot
Library    ../my_library/login_library.py
Suite Setup    Launch Browser
Suite Teardown    Close The Browser
Documentation    This test suite verifies login functionality for Swag labs app.

*** Test Cases ***
Test Valid Credentials
    [Documentation]    This Test verifies the valid user can Login the application and land on the product page.
    Navigate To Application
    Input Credentials
    Click Login
    Dashboard Validation
    Capture Page Screenshot
    Close The Browser




