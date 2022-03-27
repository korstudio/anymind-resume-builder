//
//  ResumeListRouter.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit

protocol ResumeListRoutingLogic {
    func routeToBuilder()
}

protocol ResumeListDataPassing {
    var dataStore: ResumeListDataStore? { get }
}

class ResumeListRouter: NSObject, ResumeListRoutingLogic, ResumeListDataPassing {
    weak var viewController: ResumeListViewController?
    var dataStore: ResumeListDataStore?

    func routeToBuilder() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navVC = storyboard.instantiateViewController(withIdentifier: "BuilderNavViewController")
        if #available(iOS 13, *) {
            navVC.isModalInPresentation = true
        }
        viewController?.present(navVC, animated: true)
    }
}
