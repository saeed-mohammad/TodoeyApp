//
//  ViewController.swift
//  Todoey
//
//  Created by saeed shaikh on 2/12/24.
//

import UIKit

class TodoListVC: UITableViewController {

    var topicArray = ["shopping","learing","traveling","music","games"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "TodoListArray") as? [String]{
            topicArray = item
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = topicArray[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    
    // display select data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(topicArray[indexPath.row])

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // add  button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Items", style: .default, handler: { _ in
            // what will happen once user click the add item btn

            if let itemText = textField.text, !itemText.isEmpty {
                self.topicArray.append(itemText)
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

