*** Settings ***
Library           AppiumLibrary

Test Teardown     Close Application

*** Test Cases ***
LoginandProgress
    Open Application    http://127.0.0.1:4723    appium:platformName=android    appium:automationName=uiautomator2    appium:deviceName=emulator-5554    appium:platformVersion=12    appium:app=E:/Hackaton/Hackaton_PC/automated_tester/Apk/nirva.apk    appium:newCommandTimeout=${3600}    appium:connectHardwareKeyboard=${True}
    Wait Until Page Contains Element    accessibility_id=Login    timeout=10
    ${el1} =    Set Variable     accessibility_id=Login
    Click Element    ${el1}
    Wait Until Page Contains Element    android=new UiSelector().className("android.widget.EditText").instance(0)    timeout=10
    
    ${el2} =    Set Variable     android=new UiSelector().className("android.widget.EditText").instance(0)
    Click Element    ${el2}
    
    Input Text    ${el2}    Jeditale@hotmail.com
    Input Text    ${el2}    Jeditale@hotmail.com
    ${el3} =    Set Variable     android=new UiSelector().className("android.widget.EditText").instance(1)
    Click Element    ${el3}
    Input Text    ${el3}    Az851422
    ${el4} =    Set Variable     class=android.widget.Button
    Click Element    ${el4}
    Wait Until Page Contains Element    accessibility_id=Get Premium    timeout=20
   
    ${el5} =    Set Variable     android=new UiSelector().className("android.widget.Button").instance(0)
    Click Element    ${el5}
    Wait Until Page Contains Element    accessibility_id=Jay    timeout=10

    ${el13} =    Set Variable     android=new UiSelector().className("android.view.View").instance(11)
    Click Element    ${el13}
    Wait Until Page Contains Element    accessibility_id=This month progress\nBreathing Exercise\nMeditation    timeout=10
    Wait Until Page Contains Element    accessibility_id=Weekly Progress\nBreathing\nMeditation\n0\n5\n10\n15\n20\n25\n0\n5\n10\n15\n20\n25    timeout=10