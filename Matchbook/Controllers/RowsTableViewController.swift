//
//  RowsTableViewController.swift
//  Matchbook
//
//  Created by Nayely on 08/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit
import CoreData

class RowsTableViewController: UITableViewController, CreateRowDelegate {
    
    var match: Match?
    var rows: [Row] = []
    var total = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDataRows()
    }
    
    func setDataRows() {
        if let match = match {
            total = 0.0
            rows = retrieveRowData(match: match)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! RowTableViewCell
        cell.row = rows[indexPath.row]
        total = total + rows[indexPath.row].earnings
        cell.totalLabel.text = "\(total)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView.fromNib("HeaderView")
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    // MARK: - CreateRowDelegate
    
    func addRow() {
        dismiss(animated: true, completion: nil)
        setDataRows()
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddRowSegue" {
            let controller = segue.destination as! CreateRowTableViewController
            controller.match = match
            controller.rows = rows
            controller.delegate = self
        } else if segue.identifier == "NoteSegue" {
            let controller = segue.destination as! NoteTableViewController
            controller.match = match
        }
    }
}

extension UIViewController {
    
    func retrieveRowData(match: Match) -> [Row] {
        if let rows = match.rows?.allObjects as? [Row] {
            return rows.sorted(by: {$0.date! < $1.date!})
        }
        return []
    }
    
    func deleteRowData(row: Row) -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(row)
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func saveRow(handicap: Int, match: Match, earnings: Double, numberMatch: Int, status: Status) -> NSManagedObject? {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let row = Row(context: managedContext)
        row.date = Date()
        row.handicap = Int64(handicap)
        row.earnings = earnings
        row.match = Int64(numberMatch)
        row.status = Int16(status.rawValue)
        match.addToRows(row)
        
        do {
            try managedContext.save()
            return row
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
}
