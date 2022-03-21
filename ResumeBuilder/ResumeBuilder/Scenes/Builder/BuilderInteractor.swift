//
//  BuilderInteractor.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BuilderBusinessLogic {}

protocol BuilderDataStore {}

class BuilderInteractor: BuilderBusinessLogic, BuilderDataStore {
    var presenter: BuilderPresentationLogic?
    var worker: BuilderWorker?
}
