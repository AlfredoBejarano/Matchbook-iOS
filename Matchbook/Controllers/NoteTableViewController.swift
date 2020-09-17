//
//  NoteTableViewController.swift
//  Matchbook
//
//  Created by Nayely on 09/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextField!
    
    var match: Match?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = match?.note {
            noteLabel.text = note
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func addNote(_ sender: UIButton) {
        if let match = match {
            _ = saveNote(note: noteTextField.text, match: match)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension UIViewController {
    
    func saveNote(note: String?, match: Match) -> NSManagedObject? {
        let managedContext = appDelegate.persistentContainer.viewContext

        match.note = note
        do {
            try managedContext.save()
            return match
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
}
