//
//  ResumeListPresenter.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit

protocol ResumeListPresentationLogic {
    func presentResumeList(response: ResumeList.Display.Response)
}

class ResumeListPresenter: ResumeListPresentationLogic {
    weak var viewController: ResumeListDisplayLogic?
    
    func presentResumeList(response: ResumeList.Display.Response) {
        viewController?.displayResumeList(viewModel: .init(resumeList: response.resumeList))
    }
}
