//
//  ResumeListInteractor.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ResumeListBusinessLogic {}

protocol ResumeListDataStore {}

class ResumeListInteractor: ResumeListBusinessLogic, ResumeListDataStore {
    var presenter: ResumeListPresentationLogic?
    var worker: ResumeListWorker?
}
