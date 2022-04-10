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
    
    init(instance: Any) {
        self = String(type: type(of: instance))
    }

    init(type: Any.Type) {
        self = String(describing: type)
    }

    func getImage() -> UIImage? {
        UIImage(named: self)
    }
    
    func orEmpty() -> String {
        return ""
    }
}
