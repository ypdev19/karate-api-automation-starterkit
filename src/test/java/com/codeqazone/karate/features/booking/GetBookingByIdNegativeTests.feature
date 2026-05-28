@negative
Feature: Booking API - Get Booking by ID Negative Tests

  Background:
    * def headers = { Content-Type: 'application/json', Accept: 'application/json' }

  # ---------------------------------------------------------
  # Get Booking By Id Negative Tests
  # ---------------------------------------------------------
  @regression
  Scenario: Get booking - ID not found
    Given url baseUrl
    And path 'booking/999999'
    And headers headers
    When method GET
    Then status 404

  @regression
  Scenario: Get booking - Invalid ID format
    Given url baseUrl
    And path 'booking/abc'
    And headers headers
    When method GET
    Then status 404