*** Settings ***
Documentation       Keyword Login page Ecommerces Anhtester
Library             SeleniumLibrary
Library             ../../CustomLibrary/CustomLibrary.py
Variables           MainPageUI.py
Resource            ../Common/common.robot

*** Keywords ***
MainPage Display
   Wait Until Element Is Visible             ${mainPage}

UserTitle Should Be
   [Arguments]    ${expectedTitle}
   ${userTitleCurrent}=   Get Text From Element    ${userTitle}
   Should Be Equal As Strings     ${userTitleCurrent}   ${expectedTitle}

Click On Logout Button
   Sleep  3s
   Click For Element    ${logOutBtn}
