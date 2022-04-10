//
//  TextViewCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit
import RxCocoa
import RxSwift

class TextViewCell: BaseInputCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var valueTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscribe(input: valueTextView) { [weak self] text in
            self?.setValues([.text: text])
            self?.publish()
        }
        
        // setup UI
        Style.applyTextInputStyles(of: valueTextView)
    }

    func set(title: String, text: String) {
        titleLabel.text = title
        valueTextView.text = text
        setValue(key: .text, value: text)
    }
}
