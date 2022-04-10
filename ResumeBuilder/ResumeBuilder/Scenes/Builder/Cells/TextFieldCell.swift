//
//  TextFieldCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldCell: BaseInputCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var valueTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscribe(input: valueTextField) { [weak self] text in
            self?.setValues([.text: text])
            self?.publish()
        }
        
        Style.applyTextInputStyles(of: valueTextField)
    }

    func set(title: String, text: String) {
        titleLabel.text = title
        valueTextField.text = text
        setValue(key: .text, value: text)
    }
}
