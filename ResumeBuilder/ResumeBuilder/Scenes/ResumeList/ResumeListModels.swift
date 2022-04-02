//
//  ResumeListModels.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit
import RealmSwift

enum ResumeList {
    struct ResumeContext {
        let id: ObjectId
        let title: String
        let date: Date
    }
    
    enum Display {
        struct Request {}
        struct Response {
            let resumeList: [ResumeContext]
        }
        struct ViewModel {
            let resumeList: [ResumeContext]
        }
    }
}
