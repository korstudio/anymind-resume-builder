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
        
        subscript<T>(_ section: Section, at index: Int = 0) -> T? {
            get {
                switch section {
                case .photo:
                    let data = photoData ?? "".data(using: .utf8)!
                    return UIImage(data: data) as? T
                case .info where index == 0, .mobile:
                    return mobile as? T
                case .info where index == 1, .email:
                    return email as? T
                case .info where index == 2, .address:
                    return address as? T
                case .career:
                    return careerObj as? T
                case .yearsExp:
                    return years as? T
                case .works:
                    return works[safe: index] as? T
                case .skills:
                    return skills[safe: index] as? T
                case .educations:
                    return educations[safe: index] as? T
                case .projects:
                    return projects[safe: index] as? T
                default:
                    return "" as? T
                }
            }
            
            set {
                switch section {
                case .photo:
                    guard let content = (newValue as? Data) else { return }
                    photoData = content
                case .info where index == 0, .mobile:
                    guard let content = (newValue as? FieldMap) else { return }
                    mobile = content.get(.mobile)
                case .info where index == 1, .email:
                    guard let content = (newValue as? FieldMap) else { return }
                    email = content.get(.email)
                case .info where index == 2, .address:
                    guard let content = (newValue as? FieldMap) else { return }
                    address = content.get(.address)
                case .career:
                    guard let content = (newValue as? FieldMap) else { return }
                    careerObj = content.get(.career)
                case .yearsExp:
                    guard let content = (newValue as? FieldMap) else { return }
                    years = content.get(.yearExp)
                case .works:
                    guard var item = works[safe: index],
                          let content = (newValue as? FieldMap)
                    else { return }
                    item.companyName = content.get(.companyName)
                    item.duration = content.get(.duration)
                case .skills:
                    guard var item = skills[safe: index],
                          let content = (newValue as? FieldMap)
                    else { return }
                    item.title = content.get(.skill)
                case .educations:
                    guard var item = educations[safe: index],
                          let content = (newValue as? FieldMap)
                    else { return }
                    item.`class` = content.get(.class)
                    item.endYear = content.get(.endYear)
                    item.gpa = content.get(.gpa)
                case .projects:
                    guard var item = projects[safe: index],
                          let content = (newValue as? FieldMap)
                    else { return }
                    item.name = content.get(.project)
                    item.teamSize = content.get(.teamSize)
                    item.summary = content.get(.summary)
                    item.techUsed = content.get(.tech)
                    item.role = content.get(.role)
                default: break
                }
            }
        }
        
        private func toString<T>(_ value: T?) -> String {
            (value as? String) ?? ""
        }
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
