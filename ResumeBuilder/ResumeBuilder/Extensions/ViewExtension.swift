//
//  ViewExtension.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 3/4/22.
//  Copyright © 2022 Methas Tariya. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
