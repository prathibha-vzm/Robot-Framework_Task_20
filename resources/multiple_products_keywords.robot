*** Settings ***
Library    SeleniumLibrary
Library    ../my_library/login_library.py
Library    ../my_library/product_library.py
Documentation    This test suite verifies login functionality, Then Add Products, Verify Products and Checkout for SwagLabs app.

*** Variables ***
${BROWSER}    chrome
${LOGIN_PAGE_ELEMENT}    xpath=//div[text()='Swag Labs']
${DASHBOARD_ELEMENT}    xpath=//span[text()='Products']
${CHECK_OUT_LOCATOR}    xpath=//button[@id='checkout']

*** Keywords ***
Launch Browser
    [Documentation]    Launches the SwagLabs app in Chrome Browser and Maximize the window
    ${URL}=    Read_URL
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Navigate To Application
    [Documentation]    This waits until the page is loaded and the element is visible
    Wait Until Element Is Visible    ${LOGIN_PAGE_ELEMENT}

Input Credentials
    [Documentation]    This Enters the Valid Username and Password into the appropriate field
    ${CREDS}=    Credentials
    ${USERNAME_LOCATOR}=    Username_Field
    ${PASSWORD_LOCATOR}=    Password_Field
    Input Text    ${USERNAME_LOCATOR}    ${CREDS["username"]}
    Input Text    ${PASSWORD_LOCATOR}    ${CREDS["password"]}
    Capture Page Screenshot    screenshots/Multiple_Products_Login.png

Click Login
    [Documentation]    This clicks on Login button
    ${LOGIN_BUTTON}=    Click Login_Button
    Click Button    ${LOGIN_BUTTON}

Dashboard Validation
    [Documentation]    This verifies the Valid user can land on Products Page
    Sleep    2s
    ${DASHBOARD_TEXT}=    Get Text    ${DASHBOARD_ELEMENT}
    Log    ${DASHBOARD_TEXT}
    IF    '${DASHBOARD_TEXT}' == 'Products'
        Log    Successfully Logged into Products Page
    ELSE
        Log    Unsuccessfull Login
    END
    Capture Page Screenshot    screenshots/Multiple_Products_Dashboard.png

Check Out
    [Documentation]    This clicks on Check Out Button
    Capture Page Screenshot    screenshots/Multiple_Products_Cart.png
    Click Button    ${CHECK_OUT_LOCATOR}

Close the Browser
    [Documentation]    This close the Browser
    Close Browser