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
    func save(request: Builder.Save.Request)
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
    var sections: [Builder.Section] {
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

    func getResumeAndDisplay(request: Builder.GetResume.Request) {
        guard let realm = try? Realm() else {
            presenter?.presentSelectedResume(response: .init(sections: sections, resume: selectedResume))
            return
        }

        let resumes = realm.objects(Resume.self)
        selectedResume = resumes.first {
            $0._id == selectedResumeId
        }
        presenter?.presentSelectedResume(response: .init(sections: sections, resume: selectedResume))
    }
    
    func save(request: Builder.Save.Request) {
        if selectedResume == nil {
            selectedResume = Resume()
        }
        
        guard let realm = try? Realm(),
              let resume = selectedResume
        else {
            presenter?.presentSaveComplete(response: .init(hasError: true))
            return
        }
        
        let totalResumes = realm.objects(Resume.self).count
        let context = request.context
        
        let info = PersonalInfo()
        info.photo = context.photoData ?? "".data(using: .utf8)!
        info.mobile = context.mobile
        info.email = context.email
        info.address = context.address
        
        let works = context.works.map { item -> WorkInfo in
            let workInfo = WorkInfo()
            workInfo.companyName = item.companyName
            workInfo.duration = item.duration
            return workInfo
        }.reduce(List<WorkInfo>()) {
            $0.append($1)
            return $0
        }
        
        let skills = context.skills.map { item -> Skill in
            Skill(value: ["title": item.title])
        }.reduce(List<Skill>()) {
            $0.append($1)
            return $0
        }
        
        let educations = context.educations.map { item -> Education in
            let educationInfo = Education()
            educationInfo.`class` = item.`class`
            educationInfo.endYear = item.endYear
            educationInfo.gpa = item.gpa.double
            return educationInfo
        }.reduce(List<Education>()) {
            $0.append($1)
            return $0
        }
        
        let projects = context.projects.map { item -> Project in
            let projectInfo = Project()
            projectInfo.name = item.name
            projectInfo.teamSize = item.teamSize.int
            projectInfo.summary = item.summary
            projectInfo.tech = item.techUsed
            projectInfo.role = item.role
            return projectInfo
        }.reduce(List<Project>()) {
            $0.append($1)
            return $0
        }
        
        resume.title = "Resume #\(totalResumes)"
        resume.info = info
        resume.careerObjective = context.careerObj
        resume.yearsExp = context.years
        resume.works = works
        resume.skills = skills
        resume.educations = educations
        resume.projects = projects
        
        try! realm.write {
            realm.add(resume, update: .modified)
            
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.presentSaveComplete(response: .init(hasError: false))
            }
        }
    }
}
