Feature: Process SMTP TLS reports
  Scenario: Process a SMTP TLS report
    Given I run `email-report-processor` interactively
    When I pipe in the file "%/sample-reports/tlsrpt/report.elm"
    And I close the stdin stream
    Then the exit status should be 0
