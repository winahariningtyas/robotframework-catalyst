*** Settings ***
Resource    ../resources/resource.robot
Library     SeleniumLibrary


*** Test Cases ***
Scenario: Buy watches in Jamtangan.com
    Given user open browser 
    When user login in web 
    And choose watch to order
    And add product to cart
    And go to shopping cart
    And input new address
    Then choose shipping method
    And validate total payment
    And choose payment method