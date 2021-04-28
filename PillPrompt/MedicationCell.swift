//
//  MedicationCell.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/6/21.
//

import UIKit

class MedicationCell: UITableViewCell {

    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var daysField: UILabel!
    @IBOutlet weak var frequencyField: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
