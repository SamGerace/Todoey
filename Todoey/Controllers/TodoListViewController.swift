//
//  ViewController.swift
//  Todoey
//
//  Created by Samuel Gerace on 4/1/19.
//  Copyright © 2019 Samuel Gerace. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [ToDoItem]()
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if let items = defaults.array(forKey: "ToDoListArray") as? [ToDoItem] {
//            itemArray = items
//        }
        
        let newItem = ToDoItem()
        newItem.itemDescription = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = ToDoItem()
        newItem2.itemDescription = "Buy Egos"
        itemArray.append(newItem2)
        
        let newItem3 = ToDoItem()
        newItem3.itemDescription = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
    }

    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView is the default name given to the automatic IB outlet for the table in UITableView
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let currentItem = itemArray[indexPath.row]
        cell.textLabel?.text = currentItem.itemDescription
        
        cell.accessoryType = currentItem.taskCompleted ? .checkmark : .none
        

        
        return cell
    }
    
    //MARK: Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        itemArray[indexPath.row].taskCompleted = !itemArray[indexPath.row].taskCompleted
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
        print(indexPath.row,tableView.cellForRow(at: indexPath)!.textLabel!.text!)

        //THIS WORKS
//        let test = tableView.cellForRow(at: indexPath)?.accessoryType
//
//        switch tableView.cellForRow(at: indexPath)?.accessoryType {
//        case .none?:
//
//            itemArray[indexPath.row].taskCompleted = true
//        default:
//             itemArray[indexPath.row].taskCompleted = false
//        }
        
//
//        //THIS DOESN'T
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .none {
//`
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        }
//
//        //BUT I CAN'T USE the question mark after .none in the if statement.  THIS IS ILLEGAL:
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .none? {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        }
        

        
    }
    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var toDoDescription = UITextField()
        //UIAlert controller to appear with text field
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create new item"
            toDoDescription = alertTextField  //this is a class, so get a reference pointer
            }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens when button is clicked
            let newItem = ToDoItem()
            newItem.itemDescription = toDoDescription.text ?? "New Item"
            self.itemArray.append(newItem)
//            self.itemArray.append(toDoDescription.text ?? "New Item")
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
     
    }
    
    
}


