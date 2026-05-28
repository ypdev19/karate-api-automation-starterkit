@negative
Feature: Booking API - Auth Negative Tests

  Background:
    * def headers = { Content-Type: 'application/json', Accept: 'application/json' }

  # ---------------------------------------------------------
  # Auth Negative Tests
  # ---------------------------------------------------------
  @regression
  Scenario: Auth with invalid credentials
    Given url baseUrl
    And path 'auth'
    And headers headers
    And request { username: 'invalid', password: 'wrong' }
    When method POST
    Then status 200
    # API returns 200 but with "reason" field  (A good rest api practice is to return 401 with an error message)
    And match response contains {"reason":"Bad credentials"}
