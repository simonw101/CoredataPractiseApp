//
//  HelloTableViewController.swift
//  CoreData Practise
//
//  Created by Simon Wilson on 08/12/2020.
//

import UIKit

class HelloTableViewController: UITableViewController {
    
    var hellos : [Hello] = []

    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let hello = Hello(context: context)
            
            hello.title = "Hello"
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            loadData()
            
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    
    func loadData() {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let hellos = try? context.fetch(Hello.fetchRequest()) as? [Hello] {
                
                self.hellos = hellos
                
                tableView.reloadData()
                
            }
            
        }
        
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hellos.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let hello = hellos[indexPath.row]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.delete(hello)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()

            loadData()
            
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = hellos[indexPath.row].title

        return cell
    }
    

    

}
