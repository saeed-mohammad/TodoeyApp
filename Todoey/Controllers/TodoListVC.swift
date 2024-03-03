//
//  ViewController.swift
//  Todoey
//
//  Created by saeed shaikh on 2/12/24.
//

import UIKit

class TodoListVC: UITableViewController {

    var topicArray = [TodoList]()
//    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(dataFilePath)
        let item1 = TodoList()
        item1.title = "New Todo"
        topicArray.append(item1)
        
        
//        if let item = defaults.array(forKey: "TodoListArray") as? [TodoList]{
//            topicArray = item
//        }
        loadItem()
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
//        tableView.reloadData()
        saveItems()
        
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
//                self.defaults.set(self.topicArray, forKey: "TodoListArray")
//                let encoder = PropertyListEncoder()
//                do{
//                    let data = try encoder.encode(self.topicArray)
//                    try data.write(to: self.dataFilePath!)
//                }catch{
//                    print("Error data encoding item array \(error)")
//                }
                
//                self.tableView.reloadData()
                self.saveItems()
            }
            
        })
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add your Todo topic"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(topicArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error data encoding item array \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItem(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            topicArray = try decoder.decode([TodoList].self, from: data)
            }catch{
                print("Error decoding item array \(error)")
            }
        }
    }
    
}

