//
//  ViewController.swift
//  Todoey
//
//  Created by saeed shaikh on 2/12/24.
//

import UIKit
import CoreData

class TodoListVC: UITableViewController {
    
    var topicArray = [TodoList]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        
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
                
//                let newItem = TodoList()
                let newItem = TodoList(context: self.context)
                
                newItem.title = itemText
                newItem.done = false
                self.topicArray.append(newItem)
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
        do{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItem(){
        let request : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        do{
            topicArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
    }
    
}

