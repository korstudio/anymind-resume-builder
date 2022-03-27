//
//  ProjectInputCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit

class ProjectInputCell: UITableViewCell {
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var teamSizeTextField: UITextField!
    @IBOutlet private var summaryTextField: UITextField!
    @IBOutlet private var techTextField: UITextField!
    @IBOutlet private var roleTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(title: String, teamSize: String, summary: String, techUsed: String, role: String) {
        titleTextField.text = title
        teamSizeTextField.text = teamSize
        summaryTextField.text = summary
        techTextField.text = techUsed
        roleTextField.text = role
    }
}
