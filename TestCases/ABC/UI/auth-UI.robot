*** Settings ***
Documentation       Test Case Login
Library             ../../CustomLibrary/CustomLibrary.py
Resource            ../../../PageObjects/LoginPage/LoginKW.robot
Resource            ../../../PageObjects/Common/common.robot
Variables           ../../../Data/auth/UI/auth.yaml
Test Setup          common.Open My Browser
Test Teardown       common.Close My Browser


*** Test Cases ***
RKD-7462-Verify that show list username with click on Username field
    [Documentation]  List user name display correctly
    [Tags]  RKD-7462
    Click On UserName Field
    Verify UserName List Display Correct     @{7462.userNamelistExpected}

RKD-7463-Verify that can select username in list username
    [Documentation]  Can select an username in list username  
    ...              and user name display correct
    [Tags]  RKD-7463
    Verify Username Displays Correct With Each Selection     @{7463.userNamelist}

RKD-7469-Verify that password is hidden when user inputs
    [Documentation]  Password default is hidden when user inputs 
    [Tags]  RKD-7469
    Click On Password Field
    Enter Password      ${7469.password}   
    Verify Password Is Hidden
            
RKD-7470-Verify that can show Password when click on icon "password reveal"
    [Documentation]  Show password when click on icon "password reveal" 
    [Tags]  RKD-7470
    Click On Password Field
    Enter Password    ${7470.password}
    Click On Password Reveal Button    
    Verify Password Is Revealed     
