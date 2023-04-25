*** Settings ***
Library     SeleniumLibrary
Library     ../../CustomLibrary/CustomLibrary.py
Resource    ../LoginPage/LoginKW.robot

*** Variables ***
${URL}          
*** Keywords ***
Open My Browser
    ${options}=    Evaluate
...     sys.modules['selenium.webdriver'].ChromeOptions()
...     sys, selenium.webdriver
    Call Method   ${options}        add_extension  ${CURDIR}/../../CustomLibrary/ublock.crx
    Call Method   ${options}        add_argument  --ignore-certificate-errors
    Create WebDriver    Chrome      chrome_options=${options}
    Go To          ${URL}
    Maximize Browser Window
    Verify Current URL
    

Close My Browser
    Sleep  2s
    Close Browser

Click For Element
    [Arguments]                         ${element}
    Wait Until Element Is Visible       ${element}
    Click Element                       ${element}

Input For Text
    [Arguments]                         ${element}      ${input}
    Wait Until Element Is Visible       ${element}
    Input Text                          ${element}      ${input}

Verify Current URL
    ${curURL}=                          Get Location
    Log To Console                      ${curURL}
    [Return]                            ${curURL}

Get Text From Element
    [Arguments]                         ${element}
    Wait Until Element Is Visible       ${element}     timeout=60s
    ${input}=    Get Text               ${element}
    [Return]    ${input}


Capture Page When Result Passed
    [Arguments]     ${tagName}
    ${date}=  Convert Date To String
    Capture Page Screenshot  Screenshot/${tagName}_${date}.png
    