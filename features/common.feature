Feature: Show common information for tooling

  Scenario: Show general help
    When I run `../../bin/product-type-generator`
    Then the exit status should be 1
    And the output should contain:
    """
    Usage: node ./product-type-generator
    """