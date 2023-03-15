*** Settings ***
Documentation       Keyword Login page Ecommerces Anhtester
Library             SeleniumLibrary
Library             ../../CustomLibrary/CustomLibrary.py
Library    ../../.venv/lib/site-packages/robot/libraries/Collections.py
Variables           LoginUI.py
Resource            ../Common/common.robot
Resource            ../MainPage/MainPageKW.robot

*** Keywords ***
Click On UserName Field
    Click For Element             ${userNameTxt}

Click On Password Field
    Click For Element             ${passwordTxt}

Get List UserName
    Wait Until Element Is Visible    ${userNameListBox}
    ${userNameList}=   Get List Value    ${userNameListBox}
    [Return]   ${userNameList}

Verify UserName List Display Correct
    [Arguments]     @{userNameExpected}
    ${userNameList}=   Get List UserName
    ${list}=  Create List       @{userNameExpected}
    Lists Should Be Equal       ${userNameList}    ${list}
    
Enter Password
    [Arguments]     ${input}
    Input For Text                ${passwordTxt}      ${input}

Click On Button Login
    Click For Element             ${loginBtn}

Click On Password Reveal Button
    Click For Element             ${passwordRevealBtn}

Login Page Displays Correctly
    Wait Until Element Is Visible    ${loginPage}
    Element Should Be Visible    ${userNameTxt}
    Element Should Be Visible    ${passwordTxt}

Select An UserName
    [Arguments]      ${selectedUserName}
    Wait Until Element Is Visible    ${userNameTxt}
    Click On UserName Field
    Wait Until Element Is Visible    ${userNameListBox}
    Select By Value On List    ${userNameListBox}    ${selectedUserName}
    Wait Until Element Is Not Visible    ${userNameListBox}

Error Message Should Be
   [Arguments]       ${expectedMessage}
   ${errorMessageCurrent}=   Get Text From Element    ${errorMessageAlert} 
   Should Be Equal As Strings     ${errorMessageCurrent}   ${expectedMessage}


Verify UserName Displays Correctly On Textbox
    [Arguments]      ${userName}
    ${text}=   Get Text From Element    ${userNameTxt}
    Should Be Equal    ${userName}    ${text}

Verify Username Displays Correct With Each Selection
    [Arguments]     @{userNameExpected}
    FOR    ${userName}    IN    @{userNameExpected}
        Run Keywords   Select An UserName    ${userName}           
        ...   AND      Verify UserName Displays Correctly On Textbox    ${userName}   
    END

Verify Password Is Hidden
   ${value}=   Get Css Value Property     ${passwordTxt}      -webkit-text-security
   Should Be Equal    ${value}    disc

Verify Password Is Revealed
   ${value}=   Get Css Value Property     ${passwordTxt}      -webkit-text-security
   Should Be Equal    ${value}    none
         
Verify Error Message Displays When Input Wrong Password
   [Arguments]           ${userName}     ${password}    ${expectedMessage}
   Select An UserName    ${userName}     
   Enter Password        ${password}
   Click On Button Login
   Error Message Should Be      ${expectedMessage}   

Verify Error Message Displays When Input Wrong Password With Each UserName
   [Arguments]   ${password}      ${expectedMessage}    @{userNameList}
   FOR    ${userName}    IN    @{userNameList} 
        Run Keyword   Verify Error Message Displays When Input Wrong Password    ${userName}    ${password}    ${expectedMessage}           
   END

MainPage Displays With Correct User
   [Arguments]           ${expectedUserTitle}
   MainPage Display     
   UserTitle Should Be   ${expectedUserTitle}

RoleID and SessionID Is Correct
   [Arguments]    ${expectedSessionValue}
   ${is_key_exist}=  Is Contain Key In Session Storage   ABC
   IF  ${is_key_exist} == ${True}
       ${value} =    Get Session Storage Value  ABC
       Dictionaries Should Be Equal    ${value}    ${expectedSessionValue}
   ELSE
       Fail  "Key not exist"
   END

RoleID and SessionID Is Clear
   ${is_key_exist}=  Is Contain Key In Session Storage   ABC
   Should Be Equal   ${is_key_exist}    ${False}
   