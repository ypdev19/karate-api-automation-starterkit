@positive
Feature: Booking CRUD - Happy Path

  Background:
    * def headers = { Content-Type: 'application/json', Accept: 'application/json' }

  # ---------------------------------------------------------
  # A single scenario is implemented to reuse the same booking id across all tests
  # ---------------------------------------------------------
  @smoke
  @regression
  Scenario: Auth and Full CRUD Flow
    # ---------------------------------------------------------
    # 1. Auth - Get Token (runs first to set global token)
    # ---------------------------------------------------------
    Given url baseUrl
    And path 'auth'
    And headers headers
    And request { username: 'admin', password: 'password123' }
    When method POST
    Then status 200
    And match response == { token: '#string' }
    * def authToken = response.token
    * print 'Token obtained: ' + authToken

    # --- CREATE ---
    * def payload = read('classpath:com/codeqazone/karate/payload/booking.json')
    Given url baseUrl
    And path 'booking'
    And headers headers
    And request payload
    When method POST
    Then status 200
    And match response.bookingid == '#number'
    * def bookingId = response.bookingid
    * print 'Booking created with ID: ' + bookingId

    # --- GET ---
    Given url baseUrl
    And path 'booking/' + bookingId
    And headers headers
    When method GET
    Then status 200
    And match response.firstname == 'Jim'
    And match response.lastname == 'Brown'

    # --- UPDATE ---
    * def updateHeaders = headers
    * set updateHeaders.Cookie = 'token=' + authToken

    * def updatePayload = read('classpath:com/codeqazone/karate/payload/booking.json')
    * set updatePayload.firstname = 'UpdatedName'

    Given url baseUrl
    And path 'booking/' + bookingId
    And headers updateHeaders
    And request updatePayload
    When method PUT
    Then status 200
    And match response.firstname == 'UpdatedName'

    # --- DELETE ---
    Given url baseUrl
    And path 'booking/' + bookingId
    And headers updateHeaders
    When method DELETE
    Then status 201

    # --- VERIFY DELETION ---
    Given url baseUrl
    And path 'booking/' + bookingId
    And headers headers
    When method GET
    Then status 404
