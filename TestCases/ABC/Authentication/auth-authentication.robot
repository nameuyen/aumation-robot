*** Settings ***
Documentation       Test Case Login
...                 Run test: robot  -i [Tags]  --outputdir Report\nxg-auth   TestCases\ABC\Authentication\auth-authentication.robot
Library             ../../CustomLibrary/CustomLibrary.py
Resource            ../../../PageObjects/LoginPage/LoginKW.robot
Resource            ../../../PageObjects/Common/common.robot
Variables           ../../../Data/RKD-605-nxg-auth/UI/nxg-auth.yaml
Test Setup          common.Open My Browser
Test Teardown       common.Close My Browser


*** Test Cases ***
RKD-7474-The error message displayed when clicking on Login button with wrong Password
    [Documentation]  The error message displayed when clicking on Login button with wrong Password
    [Tags]  RKD-7474
    Verify Error Message Displays When Input Wrong Password With Each UserName    ${7474.password}    ${7474.expectedErrorMessage}       @{7474.userNameList} 
    Capture Page When Result Passed      RKD-7474       
   
RKD-7475_1-Main page screen displayed correctly when clicking on Login button with user is Operator
    [Documentation]  Main page screen displayed correctly when clicking on Login button with user is Operator
    [Tags]  RKD-7475   RKD-7475_1
    Select An UserName    ${7475_1.userName}
    Enter Password        ${7475_1.password}
    Click On Button Login
    MainPage Displays With Correct User   ${7475_1.userTitle}   
    Capture Page When Result Passed      RKD-7475_1

RKD-7475_2-Main page screen displayed correctly when clicking on Login button with user is Maintainer
    [Documentation]  Main page screen displayed correctly when clicking on Login button with user is Operator
    [Tags]  RKD-7475   RKD-7475_2
    Select An UserName    ${7475_2.userName}
    Enter Password        ${7475_2.password}
    Click On Button Login
    MainPage Displays With Correct User   ${7475_2.userTitle}  
    Capture Page When Result Passed      RKD-7475_2

RKD-7475_3-Main page screen displayed correctly when clicking on Login button with user is Engineer
    [Documentation]  Main page screen displayed correctly when clicking on Login button with user is Operator
    [Tags]  RKD-7475   RKD-7475_3
    Select An UserName    ${7475_3.userName}
    Enter Password        ${7475_3.password}
    Click On Button Login
    MainPage Displays With Correct User   ${7475_3.userTitle}      
    Capture Page When Result Passed      RKD-7475_3

RKD-7475_4-Main page screen displayed correctly when clicking on Login button with user is Admin
    [Documentation]  Main page screen displayed correctly when clicking on Login button with user is Operator
    [Tags]  RKD-7475   RKD-7475_4
    Select An UserName    ${7475_4.userName}
    Enter Password        ${7475_4.password}
    Click On Button Login
    MainPage Displays With Correct User   ${7475_4.userTitle}  
    Capture Page When Result Passed      RKD-7475_4

RKD-7475_5-Main page screen displayed correctly when clicking on Login button with user is Accretech
    [Documentation]  Main page screen displayed correctly when clicking on Login button with user is Operator
    [Tags]  RKD-7475   RKD-7475_5
    Select An UserName    ${7475_5.userName}
    Enter Password        ${7475_5.password}
    Click On Button Login
    MainPage Displays With Correct User   ${7475_5.userTitle}  
    Capture Page When Result Passed      RKD-7475_5

RKD-7476_1-Login page screen displayed correctly when clicking on Logout button with user is Operator
    [Documentation]  Login page screen displayed correctly when clicking on Logout button with user is Operator
    [Tags]  RKD-7476   RKD-7476_1
    Select An UserName    ${7476_1.userName}
    Enter Password        ${7476_1.password}
    Click On Button Login
    Click On Logout Button
    Login Page Displays Correctly
    Capture Page When Result Passed      RKD-7476_1

RKD-7476_2-Login page screen displayed correctly when clicking on Logout button with user is Maintainer
    [Documentation]  Login page screen displayed correctly when clicking on Logout button with user is Maintainer
    [Tags]  RKD-7476   RKD-7476_2
    Select An UserName    ${7476_2.userName}
    Enter Password        ${7476_2.password}
    Click On Button Login
    Click On Logout Button
    Login Page Displays Correctly
    Capture Page When Result Passed      RKD-7476_2

RKD-7476_3-Login page screen displayed correctly when clicking on Logout button with user is Engineer
    [Documentation]  Login page screen displayed correctly when clicking on Logout button with user is Engineer
    [Tags]  RKD-7476   RKD-7476_3
    Select An UserName    ${7476_3.userName}
    Enter Password        ${7476_3.password}
    Click On Button Login
    Click On Logout Button
    Login Page Displays Correctly
    Capture Page When Result Passed      RKD-7476_3

RKD-7476_4-Login page screen displayed correctly when clicking on Logout button with user is Admin
    [Documentation]  Login page screen displayed correctly when clicking on Logout button with user is Admin
    [Tags]  RKD-7476   RKD-7476_4
    Select An UserName    ${7476_4.userName}
    Enter Password        ${7476_4.password}
    Click On Button Login
    Click On Logout Button
    Login Page Displays Correctly
    Capture Page When Result Passed      RKD-7476_4

RKD-7476_5-Login page screen displayed correctly when clicking on Logout button with user is Accretech
    [Documentation]  Login page screen displayed correctly when clicking on Logout button with user is Accretech
    [Tags]  RKD-7476   RKD-7476_5
    Select An UserName    ${7476_5.userName}
    Enter Password        ${7476_5.password}
    Click On Button Login
    Click On Logout Button
    Login Page Displays Correctly
    Capture Page When Result Passed      RKD-7476_5

RKD-7482_1-Verify save roleId and userId in browser session storage after login success with user is Operator
    [Documentation]  Verify save roleId and userId in browser session storage after login success with user is Operator
    [Tags]  RKD-7482   RKD_7482_1
    Select An UserName    ${7482_1.userName}
    Enter Password        ${7482_1.password}
    Click On Button Login
    Sleep    3s
    RoleID and SessionID Is Correct    ${7482_1.expectedSessionValue}

RKD-7482_2-Verify save roleId and userId in browser session storage after login success with user is Maintainer
    [Documentation]  Verify save roleId and userId in browser session storage after login success with user is Maintainer
    [Tags]  RKD-7482   RKD_7482_2
    Select An UserName    ${7482_2.userName}
    Enter Password        ${7482_2.password}
    Click On Button Login
    Sleep    3s
    RoleID and SessionID Is Correct    ${7482_2.expectedSessionValue}

RKD-7482_3-Verify save roleId and userId in browser session storage after login success with user is Engineer
    [Documentation]  Verify save roleId and userId in browser session storage after login success with user is Engineer
    [Tags]  RKD-7482   RKD_7482_3
    Select An UserName    ${7482_3.userName}
    Enter Password        ${7482_3.password}
    Click On Button Login
    Sleep    3s
    RoleID and SessionID Is Correct    ${7482_3.expectedSessionValue}

RKD-7482_4-Verify save roleId and userId in browser session storage after login success with user is Admin
    [Documentation]  Verify save roleId and userId in browser session storage after login success with user is Admin
    [Tags]  RKD-7482   RKD_7482_4
    Select An UserName    ${7482_4.userName}
    Enter Password        ${7482_4.password}
    Click On Button Login
    Sleep    3s
    RoleID and SessionID Is Correct    ${7482_4.expectedSessionValue}

RKD-7482_5-Verify save roleId and userId in browser session storage after login success with user is Accretech
    [Documentation]  Verify save roleId and userId in browser session storage after login success with user is Accretech
    [Tags]  RKD-7482   RKD_7482_5
    Select An UserName    ${7482_5.userName}
    Enter Password        ${7482_5.password}
    Click On Button Login
    Sleep    3s
    RoleID and SessionID Is Correct    ${7482_5.expectedSessionValue}

RKD-7482_1-Verify clear roleId and userId in browser session storage after logout success with user is Operator
    [Documentation]  Verify save roleId and userId in browser session storage after login success with user is Operator
    [Tags]  RKD-7483   RKD_7483_1
    Select An UserName    ${7482_1.userName}
    Enter Password        ${7482_1.password}
    Click On Button Login
    Sleep    3s
    Click On Logout Button
    Sleep    3s
    RoleID and SessionID Is Clear        
