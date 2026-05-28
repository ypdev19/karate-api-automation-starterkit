function fn() {
  var env = karate.env || 'local'; // system property: dev, qa, stage, etc.

  var config = {
    baseUrl: 'https://restful-booker.herokuapp.com'
  };

  // Simple log to show configuration is loaded
  karate.log('Karate Config loaded. Env:', env, 'BaseURL:', config.baseUrl);

  return config;
}