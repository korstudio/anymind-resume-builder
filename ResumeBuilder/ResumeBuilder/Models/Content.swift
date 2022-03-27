//
// Content
// ResumeBuilder
//
// Created by Methas Tariya on 21/3/22.
// Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import Foundation

enum Content {
    struct WorkSummaryItem {
        var companyName = ""
        var durations = ""
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