*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/invalid_login_keywords.robot
Library    ../my_library/login_library.py
Suite Setup    Launch Browser
Suite Teardown    Close The Browser
Documentation    This test suite verifies login functionality for Swag labs app.

*** Test Cases ***
Test Invalid Credentials
    [Documentation]    This Test verifies the Invalid user login and gets error message.
    Navigate To Application
    Input Credentials
    Click Login
    Capture Page Screenshot
    Close The Browser

