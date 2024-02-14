//
//  ViewController.swift
//  Todoey
//
//  Created by saeed shaikh on 2/12/24.
//

import UIKit

class TodoListVC: UITableViewController {

    var topicArray = [TodoList]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = TodoList()
        item1.title = "sid"
        topicArray.append(item1)
        
        let item2 = TodoList()
        item2.title = "avengers"
        topicArray.append(item2)
        
        let item3 = TodoList()
        item3.title = "mangas"
        topicArray.append(item3)
        
//        if let item = defaults.array(forKey: "TodoListArray") as? [String]{
//            topicArray = item
//        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = topicArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    // display select data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(topicArray[indexPath.row])
        
        topicArray[indexPath.row].done = !topicArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // add  button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Items", style: .default, handler: { _ in
            // what will happen once user click the add item btn

            if let itemText = textField.text, !itemText.isEmpty {
                
                let newItem = TodoList()
                newItem.title = itemText
                self.topicArray.append(newItem)
//                self.topicArray.append(itemText)
                self.defaults.set(self.topicArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
            
        })
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add your Todo topic"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

