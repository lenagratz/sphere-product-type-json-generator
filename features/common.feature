Feature: Show common information for tooling

  Scenario: Show general help
    When I run `product-type-generator`
    Then the exit status should be 1
    And the output should contain:
    """
    Usage:
    """

  Scenario: Show general help
    When I run `product-type-generator --attributes ../../data/tests/product-types-attributes-boolean-text-number.csv --types ../../data/tests/product-types.csv --target .`
    Then the exit status should be 0
    And the output should contain:
    """
    About to read CSV files...
    Running generator...
    """
    And the output should contain:
    """
    About to write files...
    Generated 1 files for normal product-types
    Finished generating files, checking results in target folder: .
    Found 1 files in target folder .
    Execution successfully finished
    """
    Then a file named "product-type-all.json" should exist
    And the file "product-type-all.json" should contain:
    """
    {
      "name": "all",
      "description": "The One And Only",
      "attributes": [
        {
          "name": "LocTextCFF",
          "label": {
            "de": "Lokalisierter Text",
            "en": "Localizable Text"
          },
          "type": {
            "name": "ltext"
          },
          "attributeConstraint": "CombinationUnique",
          "isRequired": false,
          "isSearchable": false,
          "inputHint": ""
        }
      ]
    }
    """
