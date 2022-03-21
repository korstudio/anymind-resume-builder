//
//  BuilderRouter.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol BuilderRoutingLogic {}

protocol BuilderDataPassing {
    var dataStore: BuilderDataStore? { get }
}

class BuilderRouter: NSObject, BuilderRoutingLogic, BuilderDataPassing {
    weak var viewController: BuilderViewController?
    var dataStore: BuilderDataStore?
}
