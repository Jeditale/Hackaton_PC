*** Settings ***
Library           AppiumLibrary

Test Teardown     Close Application

*** Test Cases ***
Loginandreminder
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
    Wait Until Page Contains Element    accessibility_id=Get Premium    timeout=10
   
    ${el5} =    Set Variable     android=new UiSelector().className("android.widget.Button").instance(0)
    Click Element    ${el5}
    Wait Until Page Contains Element    accessibility_id=Jay    timeout=10

    ${el6} =    Set Variable     android=new UiSelector().className("android.view.View").instance(7)
    Click Element    ${el6}
    Wait Until Page Contains Element    accessibility_id=Reminders    timeout=10
    ${el7} =    Set Variable     android=new UiSelector().className("android.widget.Button").instance(1)
    Click Element    ${el7}
     Wait Until Page Contains Element    accessibility_id=Set Reminder    timeout=10
    ${el8} =    Set Variable     android=new UiSelector().className("android.widget.EditText").instance(0)
    Click Element    ${el8}
    Input Text    ${el8}    Testreminder
    ${el11} =    Set Variable     accessibility_id=Sun
    Click Element    ${el11}
    ${el12} =    Set Variable     accessibility_id=Mon
    Click Element    ${el12}
    ${el13} =    Set Variable     accessibility_id=Save Reminder
    Click Element    ${el13}
    Wait Until Page Contains Element    accessibility_id=Reminders    timeout=10
    ${el14} =    Set Variable     //android.view.View[contains(@content-desc, 'Testreminder')]
    Click Element    ${el14}
    Wait Until Page Contains Element    accessibility_id=Edit Reminder    timeout=10
    ${el15} =    Set Variable     accessibility_id=Delete Reminder
    Click Element    ${el15}
    Wait Until Page Contains Element    accessibility_id=Reminders    timeout=10