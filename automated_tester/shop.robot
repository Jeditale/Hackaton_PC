*** Settings ***
Library           AppiumLibrary

Test Teardown     Close Application

*** Variables ***
${OWNED_XPATH}    (//android.widget.Button[@content-desc="Owned"])[1]
${BUY_XPATH}      (//android.widget.Button[@content-desc="Buy"])[1]

*** Test Cases ***
LoginandShop
    Open Application    http://127.0.0.1:4723    appium:platformName=android    appium:automationName=uiautomator2    appium:deviceName=emulator-5554    appium:platformVersion=12    appium:app=E:/Hackaton/Hackaton_PC/automated_tester/Apk/nirva.apk    appium:newCommandTimeout=${3600}    appium:connectHardwareKeyboard=${True}
    Wait Until Page Contains Element    accessibility_id=Login    timeout=10
    ${el1} =    Set Variable     accessibility_id=Login
    Click Element    ${el1}
    Wait Until Page Contains Element    android=new UiSelector().className("android.widget.EditText").instance(0)    timeout=10
    
    ${el2} =    Set Variable     android=new UiSelector().className("android.widget.EditText").instance(0)
    Click Element    ${el2}
    Click Element    ${el2}
    Input Text    ${el2}    Jeditale@hotmail.com
    ${el3} =    Set Variable     android=new UiSelector().className("android.widget.EditText").instance(1)
    Click Element    ${el3}
    Input Text    ${el3}    Az851422
    Input Text    ${el3}    Az851422
    ${el4} =    Set Variable     class=android.widget.Button
    Click Element    ${el4}
    Wait Until Page Contains Element    accessibility_id=Get Premium    timeout=20
   
    ${el5} =    Set Variable     android=new UiSelector().className("android.widget.Button").instance(0)
    Click Element    ${el5}
    Wait Until Page Contains Element    accessibility_id=Jay    timeout=10
    
    
    ${el6} =    Set Variable     android=new UiSelector().className("android.view.View").instance(10)
    Click Element    ${el6}
    Wait Until Page Contains Element    accessibility_id=Voice    timeout=10
    # ${el7} =    Set Variable     android=new UiSelector().description("Owned").instance(0)
    # Click Element    ${el7}
        # Check if the button displays "Owned"
    ${is_owned}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${OWNED_XPATH}    5
    Run Keyword If    ${is_owned}    Log    Button shows 'Owned'. Test done.
    
    # If not showing "Owned," check if it shows "Buy" and click
    ${is_buy}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${BUY_XPATH}    5
    Run Keyword If    ${is_buy}    Click Element    ${BUY_XPATH}
    Run Keyword If    ${is_buy}    Log    Button shows 'Buy'. Pressed 'Buy'.
    
    # # If neither is visible, fail the test
    # Run Keyword If    not ${is_owned} and not ${is_buy}    Fail    Neither 'Buy' nor 'Owned' button is visible.


