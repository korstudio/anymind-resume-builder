//
//  ResumeListRouter.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ResumeListRoutingLogic {}

protocol ResumeListDataPassing {
    var dataStore: ResumeListDataStore? { get }
}

class ResumeListRouter: NSObject, ResumeListRoutingLogic, ResumeListDataPassing {
    weak var viewController: ResumeListViewController?
    var dataStore: ResumeListDataStore?
}
