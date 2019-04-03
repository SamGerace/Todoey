//
//  ViewController.swift
//  Todoey
//
//  Created by Samuel Gerace on 4/1/19.
//  Copyright © 2019 Samuel Gerace. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [ToDoItem]()
    
  //  let defaults = UserDefaults()
  //  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
         //Load the persistent store of ToDoItems
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

//        loadItems()
        
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
        saveItems()
        
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
            let newItem = ToDoItem(context: self.context)  // newItem is a pointer to a new object in the context
            newItem.itemDescription = toDoDescription.text ?? "New Item"
            newItem.taskCompleted = false
            self.itemArray.append(newItem)
            self.saveItems()
            
            //            self.itemArray.append(toDoDescription.text ?? "New Item")
            //            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
     
    }
    
    //MARK: Model Manipulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
            
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
//    func loadItems() {
//
//        if let data = try? Data(contentsOf: dataFilePath!) {
//        let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([ToDoItem].self, from: data)
//            } catch {
//                print("Load Error")
//            }
//        }
//
//    }
    
}


