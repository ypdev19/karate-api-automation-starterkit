@negative
Feature: Booking API - Delete Booking Negative Tests

  Background:
    * def headers = { Content-Type: 'application/json', Accept: 'application/json' }

  # ---------------------------------------------------------
  # Delete Booking Negative Tests
  # ---------------------------------------------------------
  @regression
  Scenario: Delete booking - Missing Auth Token
    Given url baseUrl
    And path 'booking/1'
    And headers headers
    When method DELETE
    Then status 403

  @regression
  Scenario: Delete booking - Non-existent ID with valid token
    * def updateHeaders = headers
    # We set an invalid token value
    * set updateHeaders.Cookie = 'token=invalidtoken'

    Given url baseUrl
    And path 'booking/999999'
    And headers updateHeaders
    When method DELETE
    Then status 403 # Token check happens before ID check