Feature: Inventory (CSV export)

  Scenario: Export the current inventory list as CSV
    Given I am Mike
    And I open the inventory
    When I view the tab "Models"
    Then I can export this items data as a CSV file
    And I can export this items data as a Excel file
    And the file contains the same lines as are shown right now, including any filtering
    And the lines contain the following fields in order:
      | Fields                          |
      | Created at                      |
      | Updated at                      |
      | Product                         |
      | Version                         |
      | Manufacturer                    |
      | Description                     |
      | Technical Details               |
      | Internal Description            |
      | Important notes for hand over   |
      | Categories                      |
      | Accessories                     |
      | Compatibles                     |
      | Properties                      |
      | Inventory Code                  |
      | Serial Number                   |
      | MAC-Address                     |
      | IMEI-Number                     |
      | Name                            |
      | Note                            |
      | Retirement                      |
      | Reason for Retirement           |
      | Working order                   |
      | Completeness                    |
      | Borrowable                      |
      | Status note                     |
      | Relevant for inventory          |
      | Owner                           |
      | Last Checked                    |
      | Responsible department          |
      | Responsible person              |
      | User/Typical usage              |
      | Reference                       |
      | Project Number                  |
      | Invoice Number                  |
      | Invoice Date                    |
      | Initial Price                   |
      | Supplier                        |
      | Warranty expiration             |
      | Contract expiration             |
      | Move                            |
      | Target area                     |
      | Check-In Date                   |
      | Check-In State                  |
      | Check-In Note                   |
      | Building                        |
      | Room                            |
      | Shelf                           |
      | Borrower First name             |
      | Borrower Last name              |
      | Borrower Personal ID            |
      | Delegation Borrower First name  |
      | Delegation Borrower Last name   |
      | Delegation Borrower Personal ID |
      | Borrowed until                  |
    When I view the tab "Software"
    Then I can export this items data as a CSV file
    And I can export this items data as a Excel file
    And the file contains the same lines as are shown right now, including any filtering
    And the lines contain the following fields in order:
      | Fields                          |
      | Created at                      |
      | Updated at                      |
      | Product                         |
      | Version                         |
      | Manufacturer                    |
      | Software Information            |
      | Inventory Code                  |
      | License Version                 |
      | Serial Number                   |
      | Note                            |
      | Activation Type                 |
      | Dongle ID                       |
      | License Type                    |
      | Total quantity                  |
      | Quantity allocations            |
      | Operating System                |
      | Installation                    |
      | License expiration              |
      | Retirement                      |
      | Reason for Retirement           |
      | Borrowable                      |
      | Owner                           |
      | Responsible department          |
      | Reference                       |
      | Project Number                  |
      | Invoice Date                    |
      | Initial Price                   |
      | Supplier                        |
      | Procured by                     |
      | Maintenance contract            |
      | Maintenance expiration          |
      | Currency                        |
      | Price                           |
      | Building                        |
      | Room                            |
      | Shelf                           |
      | Borrower First name             |
      | Borrower Last name              |
      | Borrower Personal ID            |
      | Delegation Borrower First name  |
      | Delegation Borrower Last name   |
      | Delegation Borrower Personal ID |
      | Borrowed until                  |
    When I view the tab "Options"
    Then I can export this options data as a CSV file
    And I can export this options data as a Excel file
    And the file contains the same lines as are shown right now, including any filtering
    And the lines contain the following fields in order:
      | Fields                 |
      | Model Name             |
      | Inventory Code         |
      | Responsible department |
      | Categories             |
      | Initial Price          |
