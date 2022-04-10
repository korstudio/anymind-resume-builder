//
// Content
// ResumeBuilder
//
// Created by Methas Tariya on 21/3/22.
// Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import Foundation

typealias FieldMap = [Field: String]

enum Content {
    struct WorkSummaryItem {
        var companyName = ""
        var duration = ""
    }

    struct SkillItem {
        var title = ""
    }

    struct EducationItem {
        var `class` = ""
        var endYear = ""
        var gpa = ""
    }

    struct ProjectItem {
        var name = ""
        var teamSize = ""
        var summary = ""
        var techUsed = ""
        var role = ""
    }
}

enum Field {
    case photo
    case mobile
    case email
    case address
    case career
    case yearExp
    case companyName
    case duration
    case skill
    case `class`
    case endYear
    case gpa
    case project
    case teamSize
    case summary
    case tech
    case role
    case text
}

struct DisplayValue {
    var section: Builder.Section = .info
    var index: Int = 0
    var content: FieldMap = [:]
}

extension FieldMap {
    func get(_ field: Field) -> String {
        self[field] ?? ""
    }
}
