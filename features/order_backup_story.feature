Feature: Backup orders

       As an Inventory Manager
       Before starting to edit an order I want to store a backup
       in order to restore the original order if necessary

Background:
       Given a manager for inventory pool 'ABC' logs in as 'inv_man_0'

@old-ui       
Scenario: List of new and draft orders       
       Given the list of submitted orders contains 3 elements
       When lending_manager clicks on 'acknowledge'    
       Then he sees 3 submitted orders and 0 draft orders 
       When he chooses one order
       Then a backup for the order is generated
       When lending_manager clicks on 'acknowledge'    
       Then he sees 2 submitted orders and 1 draft order 

@old-ui
Scenario: Restore an order
       Given a submitted order with 4 order lines
               And the order has 1 changes
       When lending_manager chooses the order
       Then a backup for the order is generated
       When he deletes 3 order line
       Then the order has 1 order lines
               And the order has 4 changes
       When he restores the order
       Then the restored order has the same 4 order lines as the original
               And the restored order has the same 1 changes as the original
       Then is redirected to 'acknowledge'
               And he sees 1 submitted order and 0 draft orders

@old-ui
Scenario: Approve order
       Given lending_manager works on one order
       When he approves order
       Then the order doesn't have a backup anymore    

@old-ui
Scenario: Reject order
       Given lending_manager works on one order
       When he rejects order
       Then the order doesn't have a backup anymore
       
@old-ui
Scenario: Delete order
       Given lending_manager works on one order
       When he deletes order
       Then the order and the backup are deleted

       