@negative
Feature: Booking API - Create Booking Negative Tests

  Background:
    * def headers = { Content-Type: 'application/json', Accept: 'application/json' }

  # ---------------------------------------------------------
  # Create Booking Negative Tests
  # ---------------------------------------------------------
  @regression
  Scenario: Create booking - Missing request body
    Given url baseUrl
    And path 'booking'
    And headers headers
    When method POST
    # Internal Server Error for missing required fields, a good rest api practice should return 400 instead
    Then status 500

  @regression
  Scenario: Create booking - Unknown parameter in body
    * def payload =
    """
    {
      "first": "Jim",
      "lastname": "Brown",
      "totalprice": 111,
      "depositpaid": false,
      "bookingdates": {
        "checkin": "2026-01-01",
        "checkout": "2026-01-05"
      },
      "additionalneeds": "Breakfast"
    }
    """

    Given url baseUrl
    And path 'booking'
    And headers headers
    * print payload
    And request payload
    When method POST
    # Internal Server Error (A good rest api practice should return 400 instead)
    Then status 500
