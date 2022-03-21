//
//  EducationInputCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit

class EducationInputCell: UITableViewCell {
    @IBOutlet var classTextField: UITextField!
    @IBOutlet var endYearTextField: UITextField!
    @IBOutlet var gpaTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
