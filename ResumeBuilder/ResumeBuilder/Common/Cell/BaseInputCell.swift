//
// BaseInputCell
// ResumeBuilder
//
// Created by Methas Tariya on 28/3/22.
// Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class BaseInputCell: UITableViewCell {
    let value = PublishRelay<DisplayValue>()
    let disposeBag = DisposeBag()
    private var storedValue = DisplayValue()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setValue(key: Field, value: String) {
        storedValue.content[key] = value
    }

    func setValues(_ val: [Field: String] = [.text: ""]) {
        storedValue.content = val
    }

    func assign(view: BuilderDisplayLogic, section: Builder.Section, indexPath: IndexPath) {
        storedValue.section = section
        storedValue.index = indexPath.row
        observeValue(in: view)
    }

    func subscribe(input: UITextField, next: @escaping (String) -> Void) {
        input.rx.text
                .subscribe { event in
                    switch event {
                    case let .next(text):
                        next(text ?? "")
                    default: break
                    }
                }
                .disposed(by: disposeBag)
    }

    func subscribe(input: UITextView, next: @escaping (String) -> Void) {
        input.rx.text
                .subscribe { event in
                    switch event {
                    case let .next(text):
                        next(text ?? "")
                    default: break
                    }
                }
                .disposed(by: disposeBag)
    }

    func observeValue(in view: BuilderDisplayLogic) {
        value
            .asDriver(onErrorJustReturn: storedValue)
            .drive(onNext: { value in
                view.updateValue(with: value)
            })
            .disposed(by: disposeBag)
    }

    func publish() {
        value.accept(storedValue)
    }
}