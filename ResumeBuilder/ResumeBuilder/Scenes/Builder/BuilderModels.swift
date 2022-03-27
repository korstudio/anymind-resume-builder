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
            default: return CGFloat.infinity
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
    }

    enum Display {
        struct Request {
            let id: String
        }

        struct Response {
            let resume: Resume
        }

        struct ViewModel {
            let resume: Resume
        }
    }
}
