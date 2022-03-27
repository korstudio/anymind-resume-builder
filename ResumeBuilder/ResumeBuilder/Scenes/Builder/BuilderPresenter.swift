//
//  BuilderPresenter.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit

protocol BuilderPresentationLogic {
    func presentSelectedResume(response: Builder.GetResume.Response)
}

class BuilderPresenter: BuilderPresentationLogic {
    weak var viewController: BuilderDisplayLogic?

    func presentSelectedResume(response: Builder.GetResume.Response) {
        // parse to context
        guard let resume = response.resume else {
            viewController?.displayResume(viewModel: .init(sections: response.sections, context: .init()))
            return
        }
        let personalInfo = resume.info
        var context = Builder.ResumeContext()
        context.photoData = personalInfo?.photo
        context.mobile = personalInfo?.mobile ?? ""
        context.email = personalInfo?.email ?? ""
        context.address = personalInfo?.address ?? ""
        context.careerObj = resume.careerObjective
        context.years = resume.yearsExp
        context.works = resume.works.map {
            Content.WorkSummaryItem(companyName: $0.companyName, duration: $0.duration)
        }
        context.skills = resume.skills.map {
            Content.SkillItem(title: $0.title)
        }
        context.educations = resume.educations.map {
            Content.EducationItem(class: $0.class, endYear: $0.endYear, gpa: String(format: "%.2f", $0.gpa))
        }
        context.projects = resume.projects.map {
            Content.ProjectItem(name: $0.name, teamSize: "\($0.teamSize)", summary: $0.summary, techUsed: $0.tech, role: $0.role)
        }

        viewController?.displayResume(viewModel: .init(sections: response.sections, context: context))
    }
}
