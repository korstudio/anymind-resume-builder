//
// StringExtension
// ResumeBuilder
//
// Created by Methas Tariya on 27/3/22.
// Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var uiColor: UIColor {
        return .init(hex: self)
    }
    
    var int: Int {
        Int(self) ?? 0
    }
    
    var double: Double {
        Double(self) ?? 0.0
    }
    
    init(instance: Any) {
        self = String(type: type(of: instance))
    }

    init(type: Any.Type) {
        self = String(describing: type)
    }

    func getImage() -> UIImage? {
        UIImage(named: self)
    }
}
