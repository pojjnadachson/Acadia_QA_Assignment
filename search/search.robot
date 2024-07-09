*** Settings ***
Library         Browser    auto_closeing_level=MANUAL
Library         Collections
Library         OperatingSystem
Library         XML
Variables       ../datatest/url_search.yaml


*** Variables ***
@{RESULT_INDEX}     2    3    4


*** Test Cases ***
Search Rattana Bundit University
    New Browser    chromium    headless=No
    New Page    ${url_google}
    Fill Text    css=[name=q]    Rattana Bundit University
    Keyboard Key    press    Enter
    FOR    ${i}    IN    @{RESULT_INDEX}
        ${elements}=    Get Elements    css=a:has(>h3)
        ${element}=    Set Variable    ${elements}[${i}]
        Click    ${element}
        Wait Until Network Is Idle
        Get Url    ==    ${expected_search_result}[${i}]
        Go Back
    END

