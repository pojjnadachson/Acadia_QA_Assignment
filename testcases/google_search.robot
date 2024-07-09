*** Settings ***
Library         Browser      auto_closing_level=MANUAL
Variables       ../datatest/google_search..yaml


*** Variables ***
@{RESULT_INDEX}     2    3    4


*** Test Cases ***
Google search result
    New Browser    chromium    headless=No
    New Page    ${url_google}
    Fill Text    css=[name=q]    ${search_term}
    Keyboard Key    press    Enter
    FOR    ${i}    IN   @{RESULT_INDEX}
        ${elements}=    Get Elements    css=a:has(>h3)
        ${element}=    Set Variable    ${elements}[${i}]
        Click    ${element}
        Wait Until Network Is Idle         # Wait untill pages load successful
        Get Url    ==    ${expected_search_result}[${i}]     # Compare current url with expected result
        Go Back
    END

