//
//  MatchTableViewController.swift
//  Matchbook
//
//  Created by Nayely on 08/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit
import CoreData

class MatchTableViewController: UITableViewController {
    
    var matches: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        matches = retrieveData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchTableViewCell
        cell.match = matches[indexPath.row]
        return cell
    }
    
    // MARK: - Tableview delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "RowSegue", sender: matches[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if deleteData(match: matches[indexPath.row]) {
                matches.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addMatch(_ sender: Any) {
        let alert = UIAlertController(title: "New Match", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first, let name = textField.text else {
                return
            }
            if let match = self.save(name: name) {
                self.matches.append(match)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RowSegue" {
            let controller = segue.destination as! RowsTableViewController
            controller.match = sender as? Match
        }
    }
}

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func retrieveData() -> [Match] {
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            return try managedContext.fetch(Match.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteData(match: Match) -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(match)
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func save(name: String) -> Match? {
        let match = Match(context: appDelegate.persistentContainer.viewContext)
        match.name = name
        match.date = Date()
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
            return match
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
}
