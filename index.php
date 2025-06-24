<?php

// Define a function to check for vulnerabilities
function check_vulnerabilities() {
  // Include the vulnerable library (in this case, a fictional one called "vulnerable-lib")
  include 'vulnerable-lib.php';

  // Trigger an error in the vulnerable library
  $vulnerable_lib = new VulnerableLib();
  $vulnerable_lib->some_function();
}

// Define the main function to serve the webpage
function serve_webpage() {
  // Create a new HTTP response object
  $response = array(
    'status' => '200 OK',
    'headers' => array('Content-Type: text/html'),
    'body' => '<html><body>Hello World!</body></html>'
  );

  // Send the HTTP response back to the client
  header($response['status']);
  echo $response['body'];
}

// Define a function to run the vulnerable library and check for vulnerabilities
function test_vulnerable_lib() {
  // Run the vulnerable library and trigger an error
  check_vulnerabilities();

  // Serve the webpage to allow Trivy to scan the container image
  serve_webpage();
}

// Call the main function
test_vulnerable_lib();

?>
