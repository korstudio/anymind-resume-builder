//
//  WorkInputCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit

class WorkInputCell: BaseInputCell {
    @IBOutlet private var companyTextField: UITextField!
    @IBOutlet private var durationTextField: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscribe(input: companyTextField) { [weak self] text in
            self?.setValue(key: .companyName, value: text)
            self?.publish()
        }

        subscribe(input: durationTextField) { [weak self] text in
            self?.setValue(key: .duration, value: text)
            self?.publish()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(company: String, duration: String) {
        companyTextField.text = company
        durationTextField.text = duration
        setValues([
            .companyName: company,
            .duration: duration
        ])
    }
}
