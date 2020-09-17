//
//  MatchTableViewCell.swift
//  Matchbook
//
//  Created by Nayely on 08/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit
import CoreData

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var initialsLabel: UILabel! {
        didSet {
            initialsLabel.setCornerRadius(initialsLabel.bounds.size.height / 2.0)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var match: NSManagedObject? {
        didSet {
            let name = match?.value(forKey: "name") as? String
            nameLabel.text = name
            initialsLabel.text = String(name?.prefix(2) ?? "").capitalizingFirstLetter()
            let date = match?.value(forKey: "date") as? Date
            dateLabel.text = date?.getStringFromDate()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Date {
    func getStringFromDate() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        return dateformatter.string(from: self)
    }
}
