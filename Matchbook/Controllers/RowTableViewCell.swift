//
//  RowTableViewCell.swift
//  Matchbook
//
//  Created by Nayely on 08/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit
import CoreData

class RowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var handicapLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var earningsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var row: NSManagedObject? {
        didSet {
            let date = row?.value(forKey: "date") as? Date
            let handicap = row?.value(forKey: "handicap") as? Int
            let earnings = row?.value(forKey: "earnings") as? Double
            let match = row?.value(forKey: "match") as? Int
            let status = row?.value(forKey: "status") as? Int
            dateLabel.text = date?.getStringFromDate()
            handicapLabel.text = "\(handicap ?? 0)"
            earningsLabel.text = "\(earnings ?? 0)"
            matchLabel.text = "\(match ?? 0)"
            switch status {
            case 0:
                statusImageView.image = UIImage(named: "win")
                statusImageView.tintColor = .green
            case 1:
                statusImageView.image = UIImage(named: "loss")
                statusImageView.tintColor = .red
            case 2:
                statusImageView.image = UIImage(named: "tie")
                statusImageView.tintColor = .orange
            default:
                return
            }
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
