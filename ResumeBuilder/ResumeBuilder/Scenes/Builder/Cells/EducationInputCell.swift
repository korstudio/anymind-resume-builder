//
//  EducationInputCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit

class EducationInputCell: BaseInputCell {
    @IBOutlet var classTextField: UITextField!
    @IBOutlet var endYearTextField: UITextField!
    @IBOutlet var gpaTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscribe(input: classTextField) { [weak self] text in
            self?.setValue(key: .class, value: text)
            self?.publish()
        }

        subscribe(input: endYearTextField) { [weak self] text in
            self?.setValue(key: .endYear, value: text)
            self?.publish()
        }

        subscribe(input: gpaTextField) { [weak self] text in
            self?.setValue(key: .gpa, value: text)
            self?.publish()
        }
    }

    func set(`class`: String, year: String, gpa: String) {
        classTextField.text = `class`
        endYearTextField.text = year
        gpaTextField.text = gpa

        setValues([
            .class: `class`,
            .endYear: year,
            .gpa: gpa
        ])
    }
}
