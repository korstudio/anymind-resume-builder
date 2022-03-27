//
//  TextFieldCell.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var valueTextField: UITextField!

    var value = PublishRelay<DisplayValue>()
    private let disposeBag = DisposeBag()
    private var storedValue = DisplayValue()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        valueTextField.rx.text
                .asDriver()
                .drive(
                    onNext: { [weak self] text in
                        self?.storedValue.content = [.text: text ?? ""]
                        if let storedValue = self?.storedValue {
                            self?.value.accept(storedValue)
                        }
                    }
                )
                .disposed(by: disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(title: String, text: String) {
        titleLabel.text = title
        valueTextField.text = text
    }

    func assign(view: BuilderDisplayLogic, section: Builder.Section, indexPath: IndexPath) {
        storedValue.section = section
        storedValue.index = indexPath.row
        value.asDriver(onErrorJustReturn: storedValue)
                .drive(onNext: { value in
                    view.updateValue(with: value)
                })
                .disposed(by: disposeBag)
    }
}
