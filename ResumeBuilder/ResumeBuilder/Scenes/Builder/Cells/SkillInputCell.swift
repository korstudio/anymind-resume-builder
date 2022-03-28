//
//  SkillInputCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit

class SkillInputCell: BaseInputCell {
    @IBOutlet private var skillTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscribe(input: skillTextField) { [weak self] value in
            self?.setValue(key: .skill, value: value)
            self?.publish()
        }
    }

    func set(skill: String) {
        skillTextField.text = skill
        setValues([.skill: skill])
    }
}
