//
//  ResumeListInteractor.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit
import RealmSwift

protocol ResumeListBusinessLogic {
    func loadSavedResume()
}

protocol ResumeListDataStore {}

class ResumeListInteractor: ResumeListBusinessLogic, ResumeListDataStore {
    var presenter: ResumeListPresentationLogic?
    var worker: ResumeListWorker?
    
    func loadSavedResume() {
        guard let realm = try? Realm() else {
            return
        }
        
        var contexts: [ResumeList.ResumeContext] = []
        
        realm
            .objects(Resume.self)
            .sorted(byKeyPath: "date", ascending: false)
            .map {
                ResumeList.ResumeContext(id: $0._id, title: $0.title, date: $0.date)
            }
            .forEach { context in
                contexts.append(context)
            }
        
        presenter?.presentResumeList(response: .init(resumeList: contexts))
    }
}
