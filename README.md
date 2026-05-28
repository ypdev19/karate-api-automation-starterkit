# Karate API Automation Blueprint & Starter Kit

## 1. Project Overview

A production-ready, lightweight Karate DSL framework template designed for testing the [RESTful Booker API](https://restful-booker.herokuapp.com/apidoc/index.html).
This beginner-friendly project showcases API testing best practices—including positive, negative, smoke, and regression scenarios. Using clean code, reusable components, and an industry-standard tagging strategy.

---

## 2. Tech Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| Java | 11 | Runtime environment |
| Karate | 1.4.1 | API testing framework |
| JUnit 5 | (via karate-junit5) | Test runner |
| Maven | 3.11.0 | Build tool |
| Cucumber Reporting | 5.7.2 | HTML test reports |

---

## 3. Project Structure

```
src/test/java/com/codeqazone/karate/
├── features/
│   ├── auth/
│   │   └── AuthNegativeTests.feature
│   ├── booking/
│   │   ├── BookingCrud.feature
│   │   ├── CreateBookingNegativeTests.feature
│   │   ├── DeleteBookingNegativeTests.feature
│   │   ├── GetBookingByIdNegativeTests.feature
│   │   └── UpdateBookingNegativeTests.feature
│   ├── payload/
│   │   └── booking.json
│   ├── runners/
│   │   ├── FullTestSuiteRunner.java
│   │   ├── RegressionRunner.java
│   │   └── SmokeRunner.java
│   ├── karate-config.js
│   └── logback-test.xml
```

---

## 4. Feature Files Documentation

### 4.1 Auth Tests

| Feature File | Tag | Description | Scenarios |
|--------------|-----|-------------|-----------|
| `AuthNegativeTests.feature` | @negative, @regression | Validates authentication failure scenarios with invalid credentials | 1 |

### 4.2 Booking Tests - Positive

| Feature File | Tag | Description | Scenarios |
|--------------|-----|-------------|-----------|
| `BookingCrud.feature` | @positive, @smoke, @regression | Full end-to-end CRUD flow: Auth → Create → Get → Update → Delete → Verify Deletion | 1 |

### 4.3 Booking Tests - Negative

| Feature File | Tag | Description | Scenarios |
|--------------|-----|-------------|-----------|
| `CreateBookingNegativeTests.feature` | @negative, @regression | Missing request body, unknown parameters | 2 |
| `DeleteBookingNegativeTests.feature` | @negative, @regression | Missing token, non-existent ID with invalid token | 2 |
| `GetBookingByIdNegativeTests.feature` | @negative, @regression | ID not found, invalid ID format | 2 |
| `UpdateBookingNegativeTests.feature` | @negative, @regression | Missing auth token, non-existent ID | 2 |

### 4.4 Test Tags Summary

| Tag | Usage | Feature Files |
|-----|-------|----------------|
| `@positive` | Happy path scenarios | BookingCrud.feature |
| `@negative` | Error/edge case scenarios | All negative test files |
| `@smoke` | Quick sanity check | BookingCrud.feature |
| `@regression` | Full test suite | All feature files |

---

## 5. Runner Classes

| Runner | Purpose | Tags Filter           |
|--------|---------|-----------------------|
| `FullTestSuiteRunner` | Executes ALL tests (positive + negative) | `@positive, negative` |
| `RegressionRunner` | Runs only @regression tagged scenarios | `@regression`         |
| `SmokeRunner` | Runs only @smoke tagged scenarios | `@smoke`              |

---

## 6. Configuration

### 6.1 karate-config.js

```javascript
function fn() {
  var env = karate.env || 'local'; // dev, qa, stage, etc.
  var config = {
    baseUrl: 'https://restful-booker.herokuapp.com'
  };
  karate.log('Karate Config loaded. Env:', env, 'BaseURL:', config.baseUrl);
  return config;
}
```

- **Base URL**: Configured for Restful Booker API
- **Environment**: Defaults to `local` (overridable via `-Dkarate.env=dev`)

---

## 7. How to Run Tests

You can either execute the runner class directly or via bash.

### 7.1 Run Specific Runner
```bash
# Smoke tests only
mvn test -Dtest=SmokeRunner

# Regression suite
mvn test -Dtest=RegressionRunner

# Full suite
mvn test -Dtest=FullTestSuiteRunner
```

### 7.1 Run by Tag
```bash
# Run only @smoke tests
mvn test -Dkarate.options="--tags:@smoke"

# Run only @regression tests
mvn test -Dkarate.options="--tags:@regression"
```

---

## 8. Reporting

After test execution, HTML reports are generated via: 

1. Cucumber Reporting you can find in `target/cucumber-html-reports/overview-features.html`.
2. The native karate report you can find in `target/karate-reports/karate-summary.html`.

---

## 9. Key Features & Best Practices

✅ **Tag-based test organization system** (@smoke, @regression, @positive, @negative)  
✅ **Modular feature file structure** (auth/, booking/)  
✅ **Reusable payloads** via `read('classpath:...')`  
✅ **Full integration test** covering the complete booking lifecycle 
✅ **Auth token management** stored and reused across scenarios  
✅ **Comprehensive negative test coverage**
✅ **Beginner-friendly and easy to extend**

## 📄 License

This project is open-source and available under the [MIT License](./LICENSE). You are free to use, modify, and distribute it with proper attribution.
