Feature: Process DMARC reports
  Scenario: Process a DMARC report
    Given I run `email-report-processor --dmarc` interactively
    When I pipe in the file "%/sample-reports/dmarc/report.elm"
    And I close the stdin stream
    Then the exit status should be 0
