//
//  BuilderInteractor.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit
import RealmSwift

protocol BuilderBusinessLogic {
    func getResumeAndDisplay(request: Builder.GetResume.Request)
}

protocol BuilderDataStore {
    var sections: [Builder.Section] { get }
    var selectedResumeId: ObjectId? { get set }
}

class BuilderInteractor: BuilderBusinessLogic, BuilderDataStore {
    var presenter: BuilderPresentationLogic?
    var worker: BuilderWorker?
    var selectedResumeId: ObjectId?
    var selectedResume: Resume?
    private(set) var sections: [Builder.Section] {
        [
            .photo,
            .info,
            .career,
            .yearsExp,
            .works,
            .skills,
            .educations,
            .projects
        ]
    }

    func getResumeAndDisplay() {
        guard let realm = try? Realm() else {
            presenter?.presentSelectedResume(response: .init(resume: nil))
            return
        }

        let resumes = realm.objects(Resume.self)
        selectedResume = resumes.first {
            $0._id == selectedResumeId
        }
        presenter?.presentSelectedResume(response: .init(resume: selectedResume))
    }
}
