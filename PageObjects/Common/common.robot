*** Settings ***
Documentation    Common keywords for all pages
Library     SeleniumLibrary
Library     ../../../CustomLibrary/CustomLibrary.py
Library     Collections
Library     Screenshot
Library     OperatingSystem


*** Variables ***
${url_login}          

*** Keywords ***
Open Chrome Browser And Go To Login Page
    ${options}=    Evaluate
    ...     sys.modules['selenium.webdriver'].ChromeOptions()
    ...     sys, selenium.webdriver
    Call Method   ${options}        add_argument  --ignore-certificate-errors
    Call Method   ${options}        add_argument  --headless
    Open Browser  url=${url_login}      browser=chrome       options=${options}
    Set Window Size    1920    1080

Close My Browser
    Sleep  2s
    Close Browser

Setup Before All Tests
    evaluate    sys.path.append(os.path.join("../../../CustomLibrary/"))    modules=os, sys

Click For Element
    [Arguments]                            ${element}
    Wait Until Page Contains Element       ${element}     10s
    Click Element                          ${element}

Click For Button
    [Arguments]                           ${element}
    Wait Until Element Is Visible         ${element}
    Click Button    ${element}

Input For Text
    [Arguments]                         ${element}      ${input}
    Wait Until Element Is Visible       ${element}
    Input Text                          ${element}      ${input}

Get Text From Element
    [Arguments]                         ${element}
    Wait Until Element Is Visible       ${element}
    ${input}=    Get Text               ${element}
    [Return]    ${input}

Get Text From List Element
    [Arguments]                         ${list_element}
    ${list_text}=  Create List
    FOR    ${element}    IN    @{list_element}
        ${text}=    Get Text From Element    ${element}
        Append To List    ${list_text}    ${text}
    END
    [Return]   ${list_text}

Get Value From Element
    [Arguments]                         ${element}
    Wait Until Element Is Visible       ${element}
    ${input}=    Get Value              ${element}
    [Return]    ${input}

Get Value Of Attribute Element
    [Arguments]                         ${element}       ${attributeName}
    Wait Until Element Is Visible       ${element}
    ${value}=     SeleniumLibrary.Get Element Attribute    ${element}    ${attributeName}
    [Return]    ${value}

Capture Page When Result Passed
    [Arguments]     ${tagName}
    ${date}=  Convert Date To String
    Capture Page Screenshot  Screenshot/${tagName}_${date}.png

Setup Data By Call Post API With Data File
    [Arguments]    ${urlPost}   ${file_path}
    ${data}=  Get File    ${file_path}
    ${postResult}=   Set Data Api    ${urlPost}    ${data}
    Run Keyword If    ${postResult} == ${False}
    ...   Fail  Setup failed

Get All Items From Child Tag Li
    [Arguments]   ${locator}
    Wait Until Element Is Visible    ${locator}
    ${element}=   Get Element By Xpath                   ${locator}
    ${elements}=  Get Elements By Child Is Tag Name      ${locator}    li
    ${textElements}=  Get Text From List Element    ${elements}
    [Return]     ${textElements}

Select By Value On List
    [Arguments]   ${locator}     ${value}    ${tagName}
    Wait Until Element Is Visible    ${locator}
    Wait For Elements Are Loaded    5s
    ${elements}=  Get Elements By Child Is Tag Name    ${locator}    li
    ${element}=   Get Element By Value On List          ${elements}    ${value}
    Click For Element    ${element}

Is Empty
    [Arguments]   ${item}
    ${is_empty}=    Run Keyword And Return Status
    ...    Should Be Empty    ${item}
    [Return]     ${is_empty}

Get Background Color
    [Arguments]    ${element}
    ${backGroundColor}=    Get Css Value Property    ${element}    background-color
    [Return]    ${backGroundColor}

Get Text Color
    [Arguments]    ${element}
    ${textColor}=    Get Css Value Property    ${element}    color
    [Return]    ${textColor}

Wait For Elements Are Loaded
    [Arguments]    ${timeSeconds}
    Sleep    ${timeSeconds}

Get All Items From List Element
    [Arguments]   ${list_element}
    ${list_item}=  Create List
    FOR    ${element}    IN    @{list_element}
        ${value}=   Get Value Of Attribute Element    ${element}    innerHTML
        Append To List    ${list_item}  ${value}
    END
    [Return]  ${list_item}

Get Text Of Child Element From Element
   [Arguments]   ${element}   ${css_child_elements}
   ${item}=  Get Child Element By Css Selector     ${element}    ${css_child_elements}
   ${item_name}=  Get Text From Element    ${item}
   [Return]      ${item_name}

Get Text Of List Child Element From Element
   [Arguments]     ${list_element}     ${css_child_elements}
   ${list_name}=  Create List
   FOR    ${element}    IN    @{list_element}
      ${name}=   Get Text Of Child Element From Element
      ...    ${element}    ${css_child_elements}
      Append To List    ${list_name}    ${name}
   END
   [Return]    ${list_name}