*** Settings ***
Library           AppiumLibrary

Test Teardown     Close Application

*** Test Cases ***
Loginandbreathing
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

    ${el6} =    Set Variable     android=new UiSelector().className("android.view.View").instance(8)
    Click Element    ${el6}
    Wait Until Page Contains Element    accessibility_id=Breathing Exercises    timeout=10
    ${el7} =    Set Variable     android=new UiSelector().description("Start").instance(0)
    Click Element    ${el7}
    Wait Until Page Contains Element    accessibility_id=Breathing Pattern    timeout=10
    ${el8} =    Set Variable     accessibility_id=Breathing Pattern
    Click Element    ${el8}
    Wait Until Page Contains Element    accessibility_id=Sleep Calm Breath   timeout=10
    ${el9} =    Set Variable     accessibility_id=Sleep Calm Breath
    Click Element    ${el9}
    ${el10} =    Set Variable     accessibility_id=Voice
    Click Element    ${el10}
    Wait Until Page Contains Element    accessibility_id=Eric   timeout=10
    ${el11} =    Set Variable     accessibility_id=Eric
    Click Element    ${el11}
    ${el12} =    Set Variable     accessibility_id=Start
    Click Element    ${el12}
    Wait Until Page Contains Element    accessibility_id=PAUSE   timeout=10
    ${el13} =    Set Variable     accessibility_id=PAUSE
    Click Element    ${el13}
    Wait Until Page Contains Element    accessibility_id=CONTINUE   timeout=10
    # ${el15} =    Set Variable     accessibility_id=CONTINUE
    # Click Element    ${el15}
    ${el14} =    Set Variable     accessibility_id=STOP
    Click Element    ${el14}
    Wait Until Page Contains Element    accessibility_id=CONTINUE   timeout=10