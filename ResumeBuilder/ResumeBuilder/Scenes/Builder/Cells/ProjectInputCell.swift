//
//  ProjectInputCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit

class ProjectInputCell: BaseInputCell {
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var teamSizeTextField: UITextField!
    @IBOutlet private var summaryTextField: UITextField!
    @IBOutlet private var techTextField: UITextField!
    @IBOutlet private var roleTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscribe(input: titleTextField) { [weak self] text in
            self?.setValue(key: .project, value: text)
            self?.publish()
        }

        subscribe(input: teamSizeTextField) { [weak self] text in
            self?.setValue(key: .teamSize, value: text)
            self?.publish()
        }

        subscribe(input: summaryTextField) { [weak self] text in
            self?.setValue(key: .summary, value: text)
            self?.publish()
        }

        subscribe(input: techTextField) { [weak self] text in
            self?.setValue(key: .tech, value: text)
            self?.publish()
        }

        subscribe(input: roleTextField) { [weak self] text in
            self?.setValue(key: .role, value: text)
            self?.publish()
        }
    }

    func set(title: String, teamSize: String, summary: String, techUsed: String, role: String) {
        titleTextField.text = title
        teamSizeTextField.text = teamSize
        summaryTextField.text = summary
        techTextField.text = techUsed
        roleTextField.text = role

        setValues([
            .project: title,
            .teamSize: teamSize,
            .summary: summary,
            .tech: techUsed,
            .role: role
        ])
    }
}
