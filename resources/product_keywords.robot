*** Settings ***
Library    SeleniumLibrary
Library    ../my_library/login_library.py
Library    ../my_library/product_library.py
Documentation    This test suite verifies login functionality for SwagLabs app.

*** Variables ***
${BROWSER}    chrome
${LOGIN_PAGE_ELEMENT}    xpath=//div[text()='Swag Labs']
${DASHBOARD_ELEMENT}    xpath=//span[text()='Products']

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
    Capture Page Screenshot    screenshots/Product_login.png

Click Login
    [Documentation]    This clicks on Login button
    ${LOGIN_BUTTON}=    Click Login_Button
    Click Button    ${LOGIN_BUTTON}

Dashboard Validation
    [Documentation]    This verifies the Valid user can land on Products Page
    ${DASHBOARD_TEXT}=    Get Text    ${DASHBOARD_ELEMENT}
    Log    ${DASHBOARD_TEXT}
    IF    '${DASHBOARD_TEXT}' == 'Products'
        Log    Successfully Logged into Products Page
    ELSE
        Log    Unsuccessfull Login
    END
        Capture Page Screenshot    screenshots/Product_Dashboard.png

Add A Product To Cart
    [Documentation]    This Add the first product from the selected filter and click on Add to Cart
    ${SELECT_ELEMENT}=    Drop Down
    Click Element    ${SELECT_ELEMENT}
    Select From List By Label    ${SELECT_ELEMENT}    Price (low to high)
    ${ITEM_NAME}=    Actual Item Name
    ${ITEM_TEXT}=    Get Text    ${ITEM_NAME}
    Log    ${ITEM_TEXT}
    ${ADD_TO_CART}=    Add Cart
    Click Button    ${ADD_TO_CART}
    Sleep    2s
    RETURN    ${ITEM_TEXT}
    Capture Page Screenshot    screenshots/Product_Adding_Item.png

Verify The Product In Cart
    [Documentation]    This click on cart icon and check the selected product and added product are same
    [Arguments]    ${EXPECTED_ITEM}
    ${CART_ICON}=    Click On Cart
    Click Element    ${CART_ICON}
    ${CART_ITEM_NAME}=    Cart Item Name
    ${CART_ITEM_TEXT}=    Get Text    ${CART_ITEM_NAME}
    Sleep    2s
    IF    '${CART_ITEM_TEXT}' == '${EXPECTED_ITEM}'
        Log    Products Matches
        Log    Actual Item Added: ${CART_ITEM_TEXT}
        Log    Expected Item in Cart: ${EXPECTED_ITEM}
    ELSE
        Log    Wromg Item Added
        Log    Actual Item Added: ${CART_ITEM_TEXT}
        Log    Expected Item in Cart: ${EXPECTED_ITEM}
    END
    Capture Page Screenshot    screenshots/Product_Cart.png

Close the Browser
    [Documentation]    This close the Browser
    Close Browser