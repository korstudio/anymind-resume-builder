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
    func routeToBuilder(with resume: ResumeList.ResumeContext)
}

protocol ResumeListDataPassing {
    var dataStore: ResumeListDataStore? { get }
}

class ResumeListRouter: NSObject, ResumeListRoutingLogic, ResumeListDataPassing {
    weak var viewController: ResumeListViewController?
    var dataStore: ResumeListDataStore?

    func routeToBuilder() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navVC = storyboard.instantiateViewController(withIdentifier: "BuilderViewController")
        viewController?.push(navVC)
    }
    
    func routeToBuilder(with resume: ResumeList.ResumeContext) {
        guard let builder = BuilderViewController.create(),
              var ds = builder.router?.dataStore
        else { return }
        passDataToBuilder(resume: resume, dataStore: &ds)
        viewController?.push(builder)
    }
    
    private func passDataToBuilder(resume: ResumeList.ResumeContext, dataStore: inout BuilderDataStore) {
        dataStore.selectedResumeId = resume.id
    }
}
