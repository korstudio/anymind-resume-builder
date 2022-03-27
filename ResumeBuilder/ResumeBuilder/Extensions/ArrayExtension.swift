//
// ArrayExtension
// ResumeBuilder
//
// Created by Methas Tariya on 28/3/22.
// Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}