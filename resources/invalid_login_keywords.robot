*** Settings ***
Library    SeleniumLibrary
Library    ../my_library/login_library.py
Documentation    This test suite verifies login functionality for SwagLabs app.

*** Variables ***
${BROWSER}    chrome
${LOGIN_PAGE_ELEMENT}    xpath=//div[text()='Swag Labs']

*** Keywords ***
Launch Browser
    [Documentation]    Launches the SwagLabs app in Chrome Browser and Maximize the window
    ${URL}=    Read_URL
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Navigate To Application
    [Documentation]    This waits until the page is loaded and the element is visible
    Sleep    5s
    Wait Until Element Is Visible    ${LOGIN_PAGE_ELEMENT}

Input Credentials
    [Documentation]    This Enters the Invalid Username and Password into the appropriate field
    ${CREDS}=    Invalid_Credentials
    ${USERNAME_LOCATOR}=    Username_Field
    ${PASSWORD_LOCATOR}=    Password_Field
    Input Text    ${USERNAME_LOCATOR}    ${CREDS["username"]}
    Input Text    ${PASSWORD_LOCATOR}    ${CREDS["password"]}
    Capture Page Screenshot    screenshots/Invalid_Login.png

Click Login
    [Documentation]    This clicks on Login button and wait for the error message to appear and report
    ${LOGIN_BUTTON}=    Click Login_Button
    Click Button    ${LOGIN_BUTTON}
    ${ERROR_MSG}=    Error Message
    ${ERROR_TXT}=    Get Text    ${ERROR_MSG}
    Wait Until Page Contains    ${ERROR_TXT}    timeout=5s
    ${is_present}=    Run Keyword And Return Status    Page Should Contain    ${ERROR_TXT}
    IF    ${is_present}
        Log    Login Failed: ${ERROR_TXT}
    ELSE
        Log    Login Successful
    END
    Capture Page Screenshot    screenshots/Invalid_Error.png

Close the Browser
    [Documentation]    This close the Browser
    Close Browser