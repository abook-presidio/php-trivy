<?php
// define vunlerable_lib function
class VulnerableLib {
  function some_function() {
    // Simulate vulnerability check
    error_log("VulnerableLib::some_function() called");
  }
}
// Define a function to check for vulnerabilities
function check_vulnerabilities() {
  // Include the vulnerable library (in this case, a fictional one called "vulnerable-lib")
//  include 'vulnerable-lib.php';

  // Trigger an error in the vulnerable library
  $vulnerable_lib = new VulnerableLib();
  $vulnerable_lib->some_function();
}

// Define the main function to serve the webpage
function serve_webpage() {
  // Get the current date and time
  $current_date = date('Y-m-d');
  $current_time = date('H:i:s');

  // Create a new HTTP response object
  $response = array(
    'status' => '200 OK',
    'headers' => array('Content-Type: text/html'),
    'body' => '<html><body>
      <h1>Hello World!</h1>
      <p>Current Date and Time: ' . $current_date . '</p>
      <p>Current Time: ' . $current_time . '</p>
      </body></html>'
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
