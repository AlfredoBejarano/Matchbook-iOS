//
//  CreateRowTableViewController.swift
//  Matchbook
//
//  Created by Nayely on 08/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit
import CoreData

enum Status: Int, CaseIterable {
    case win, loss, tie
}

protocol CreateRowDelegate: class {
    func addRow()
}

class CreateRowTableViewController: UITableViewController {
    
    @IBOutlet weak var handicapTextField: UITextField!
    @IBOutlet weak var matchTextField: UITextField!
    @IBOutlet weak var earningsTextField: UITextField!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    var status: Status = .win
    var match: Match!
    var rows: [Row] = []
    weak var delegate: CreateRowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if let lastElement = rows.last {
            handicapTextField.isHidden = true
            handicapTextField.text = "\(lastElement.handicap - 1)"
        }
    }
    
    // MARK: - Actions
    

    @IBAction func selectStatus(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            status = .win
        case 1:
            status = .loss
        case 2:
            status = .tie
        default:
            return
        }
    }
    
    @IBAction func addRow(_ sender: Any) {
        guard let handicap = Int(handicapTextField.text ?? "0") else {
            presentAlert(title: "Error", message: "Enter handicap", actions: nil)
            return
        }
        guard let numberMatch = Int(matchTextField.text ?? "0") else {
            presentAlert(title: "Error", message: "Enter match", actions: nil)
            return
        }
        guard let earnings = Double(earningsTextField.text ?? "0.0") else {
            presentAlert(title: "Error", message: "Enter earnings", actions: nil)
            return
        }
        
        _ = saveRow(handicap: handicap, match: match, earnings: earnings, numberMatch: numberMatch, status: status)
        self.delegate?.addRow()
    }
}
