*** Settings ***
Documentation   Test cases for application keywords.

Library         FlaUILibrary
Library         StringFormat

Resource        util/Common.robot
Resource        util/Error.robot
Resource        util/XPath.robot

*** Test Cases ***
Attach Application By Name
    [Setup]    Start Application
    [Teardown]  Stop Application
    Attach Application By Name   ${TEST_APP}

Attach Application By Wrong Name
    ${EXP_ERR_MSG}  Format String  ${EXP_ERR_MSG_APP_NAME_NOT_FOUND}  ${XPATH_NOT_EXISTS}
    Run Keyword And Expect Error  ${EXP_ERR_MSG}  Attach Application By Name  ${XPATH_NOT_EXISTS}

Attach Application By PID
    [Teardown]  Stop Application
    ${PID}  Launch Application  ${TEST_APP}
    Wait Until Keyword Succeeds  10x  200ms  Element Should Exist  ${MAIN_WINDOW}
    Should Not Be Equal As Integers  ${PID}  0
    Attach Application By PID    ${PID}

Attach Application By Wrong PID
    ${EXP_ERR_MSG}  Format String  ${EXP_ERR_MSG_PID_NOT_FOUND}  ${WRONG_PID}
    Run Keyword And Expect Error  ${EXP_ERR_MSG}  Attach Application By PID  ${WRONG_PID}

Close Application If Application Is Attached
    [Setup]    Start Application
    Close Application

Close Application If No Application Is Attached
    Run Keyword And Expect Error  ${EXP_ERR_MSG_APP_NOT_ATTACHED}  Close Application

Launch Application
    [Teardown]  Stop Application
    ${PID}  Launch Application  ${TEST_APP}
    Should Not Be Equal As Integers  ${PID}  0

Launch Application Not Exist
    ${EXP_ERR_MSG}  Format String  ${EXP_ERR_MSG_APP_NOT_EXIST}  ${XPATH_NOT_EXISTS}
    Run Keyword And Expect Error  ${EXP_ERR_MSG}  Launch Application  ${XPATH_NOT_EXISTS}
