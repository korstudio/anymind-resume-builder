//
//  ResumeItemCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit

class ResumeItemCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
