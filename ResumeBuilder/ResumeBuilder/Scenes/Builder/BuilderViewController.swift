//
//  BuilderViewController.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BuilderDisplayLogic: AnyObject {
    func displayResume(viewModel: Builder.RenderTable.ViewModel)
}

class BuilderViewController: UITableViewController {
    var interactor: BuilderBusinessLogic?
    var router: (NSObjectProtocol & BuilderRoutingLogic & BuilderDataPassing)?

    var sections: [Builder.Section] = []
    var resumeContext: Builder.ResumeContext = .init()

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = BuilderInteractor()
        let presenter = BuilderPresenter()
        let router = BuilderRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getResumeAndDisplay(request: .init())
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onSavePDF(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
    }
}

extension BuilderViewController: BuilderDisplayLogic {
    func displayResume(viewModel: Builder.RenderTable.ViewModel) {
        resumeContext = viewModel.context
        tableView.reloadData()
    }
}

extension BuilderViewController: UITableViewDataSource {
    public override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let theSection = sections[section]
        switch theSection {
        case .works: return resumeContext.works.count
        case .skills: return resumeContext.skills.count
        case .educations: return resumeContext.educations.count
        case .projects: return resumeContext.projects.count
        default: return theSection.rowCount
        }
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theSection = sections[indexPath.section]
        let cellType: UITableViewCell.Type
        switch theSection {
        case .photo: cellType = ImageCell.self
        case .info:
            if indexPath.row == 2 {
                cellType = TextViewCell.self
            } else {
                cellType = TextFieldCell.self
            }
        case .career: cellType = TextFieldCell.self
        case .yearsExp: cellType = TextFieldCell.self
        case .works: cellType = WorkInputCell.self
        case .skills: cellType = SkillInputCell.self
        case .educations: cellType = EducationInputCell.self
        case .projects: cellType = ProjectInputCell.self
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: String(type: cellType), for: indexPath)
        
    }
}