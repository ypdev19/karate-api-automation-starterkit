@negative
Feature: Booking API - Update Booking Negative Tests

  Background:
    * def headers = { Content-Type: 'application/json', Accept: 'application/json' }

  # ---------------------------------------------------------
  # Update Booking Negative Tests
  # ---------------------------------------------------------
  @regression
  Scenario: Update booking - Missing Auth Token
    * def payload = read('classpath:com/codeqazone/karate/payload/booking.json')
    * def invalidHeaders = { Content-Type: 'application/json', Accept: 'application/json' }

    Given url baseUrl
    And path 'booking/1'
    And headers invalidHeaders
    And request payload
    When method PUT
    Then status 403 # Forbidden (403 usually indicates "Did you try to update a booking without authenticating?"

  @regression
  Scenario: Update booking - Non-existent ID
    * def payload = read('classpath:com/codeqazone/karate/payload/booking.json')
    * def updateHeaders = headers
    * set updateHeaders.Cookie = 'token=abc123invalid'

    Given url baseUrl
    And path 'booking/999999'
    And headers updateHeaders
    And request payload
    When method PUT
    Then status 403 # Token validation happens first
