//
// Created by Methas Tariya on 21/3/22.
//

import Foundation
import RealmSwift

class Resume: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var info: PersonalInfo?
    @Persisted var careerObjective: String
    @Persisted var yearsExp: String
    @Persisted var works: List<WorkInfo>
    @Persisted var skills: List<Skill>
    @Persisted var educations: List<Education>
    @Persisted var projects: List<Project>
}

class PersonalInfo: EmbeddedObject {
    @Persisted var photo = Data()
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var mobile: String
    @Persisted var address: String
}

class WorkInfo: EmbeddedObject {
    @Persisted var companyName: String
    @Persisted var duration: String
}

class Skill: EmbeddedObject {
    @Persisted var title: String
}

class Education: EmbeddedObject {
    @Persisted var `class`: String
    @Persisted var endYear: String
    @Persisted var gpa: Double
}

class Project: EmbeddedObject {
    @Persisted var name: String
    @Persisted var teamSize: Int
    @Persisted var summary: String
    @Persisted var tech: String
    @Persisted var role: String
}