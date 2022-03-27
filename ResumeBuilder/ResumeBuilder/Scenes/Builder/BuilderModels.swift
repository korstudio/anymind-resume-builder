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
        
        var cellHeight: CGFloat {
            switch self {
            case .textField: return 100
            case .textView: return 130
            case .image: return 180
            default: return .infinity
            }
        }
    }
    
    enum Section: CaseIterable {
        case photo
        case info
        case career
        case yearsExp
        case works
        case skills
        case educations
        case projects
        
        var cellHeight: CGFloat {
            switch self {
            case .photo: return 180
            case .info: return CellType.textField.cellHeight
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
            default: return .max
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
            mutating let context: ResumeContext
        }
    }

    enum GetResume {
        struct Request {
        }

        struct Response {
            let resume: Resume?
        }

        struct ViewModel {
            let context: ResumeContext
        }
    }
}
