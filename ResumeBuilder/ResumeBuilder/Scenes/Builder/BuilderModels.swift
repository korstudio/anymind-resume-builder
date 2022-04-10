//
//  BuilderModels.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit

enum Builder {
    enum CellType {
        case textField
        case textView
        case textFieldGroup
        case image
        case addRow

        var cellHeight: CGFloat {
            switch self {
            case .textField: return 100
            case .textView: return 130
            case .image: return 180
            case .addRow: return 40
            default: return .infinity
            }
        }
    }

    enum Section {
        case photo
        case info
        case mobile
        case email
        case address
        case career
        case yearsExp
        case works
        case skills
        case educations
        case projects

        var cellHeight: CGFloat {
            switch self {
            case .photo: return 180
            case .info, .mobile, .email:
                return CellType.textField.cellHeight
            case .address: return CellType.textView.cellHeight
            case .career: return CellType.textField.cellHeight
            case .yearsExp: return CellType.textField.cellHeight
            case .works: return 110
            case .skills: return 66
            case .educations: return 150
            case .projects: return 238
            }
        }

        var rowCount: Int {
            switch self {
            case .photo,
                 .career,
                 .yearsExp:
                return 1
            case .info: return 3
            default: return 0
            }
        }

        var title: String {
            switch self {
            case .photo: return "Photo"
            case .info: return "Personal Information"
            case .career: return "Career"
            case .yearsExp: return "Experience"
            case .works: return "Work Summary"
            case .skills: return "Skills"
            case .educations: return "Educations"
            case .projects: return "Projects"
            default: return ""
            }
        }

        var cells: (title: String, type: CellType) {
            switch self {
            case .photo: return ("Photo", .image)
            case .info: return ("Personal Information", .textField)
            case .mobile: return ("Mobile number", .textField)
            case .email: return ("E-mail", .textField)
            case .address: return ("Address", .textView)
            case .career: return ("Career Objective", .textField)
            case .yearsExp: return ("Total Years of experience", .textField)
            case .works: return ("Work Summary", .textFieldGroup)
            case .skills: return ("Skills", .textFieldGroup)
            case .educations: return ("Educations", .textFieldGroup)
            case .projects: return ("Projects", .textFieldGroup)
            }
        }
    }

    struct ResumeContext {
        var photoData: Data?
        var mobile = ""
        var email = ""
        var address = ""
        var careerObj = ""
        var years = ""
        var works = [Content.WorkSummaryItem]()
        var skills = [Content.SkillItem]()
        var educations = [Content.EducationItem]()
        var projects = [Content.ProjectItem]()
    }

    enum RenderTable {
        struct ViewModel {
            var context: ResumeContext
        }
    }

    enum GetResume {
        struct Request {
        }

        struct Response {
            let sections: [Section]
            let resume: Resume?
        }

        struct ViewModel {
            let sections: [Section]
            let context: ResumeContext
        }
    }
}
