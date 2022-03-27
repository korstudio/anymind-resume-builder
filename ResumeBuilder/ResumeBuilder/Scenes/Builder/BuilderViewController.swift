//
//  BuilderViewController.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BuilderDisplayLogic: AnyObject {
    func displayResume(viewModel: Builder.GetResume.ViewModel)
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
        dismiss(animated: true)
    }
    
    @IBAction func onSavePDF(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        // TODO: implement this
        dismiss(animated: true)
    }
}

extension BuilderViewController: BuilderDisplayLogic {
    func displayResume(viewModel: Builder.GetResume.ViewModel) {
        sections = viewModel.sections
        resumeContext = viewModel.context
        tableView.reloadData()
    }
}

extension BuilderViewController {
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

        if theSection == .photo,
           let photoCell = cell as? ImageCell,
           let photoData = resumeContext.photoData {
            photoCell.set(image: .init(data: photoData))
        }

        if theSection == .info {
            let sectionCell = theSection.cells[indexPath.row]
            switch indexPath.row {
            case 0:
                let textCell = cell as? TextFieldCell
                textCell?.set(title: sectionCell.title, text: resumeContext.mobile)
            case 1:
                let textCell = cell as? TextFieldCell
                textCell?.set(title: sectionCell.title, text: resumeContext.email)
            case 2:
                let textViewCell = cell as? TextViewCell
                textViewCell?.set(title: sectionCell.title, text: resumeContext.address)
            default: break
            }
        }

        if theSection == .career,
           let title = theSection.cells.first?.title {
            let textCell = cell as? TextFieldCell
            textCell?.set(title: title, text: resumeContext.careerObj)
        }

        if theSection == .yearsExp,
           let title = theSection.cells.first?.title {
            let textCell = cell as? TextFieldCell
            textCell?.set(title: title, text: resumeContext.years)
        }

        if theSection == .works,
           let workCell = cell as? WorkInputCell,
           let workItem = resumeContext.works[safe: indexPath.row] {
            workCell.set(company: workItem.companyName, duration: workItem.duration)
        }

        if theSection == .skills,
           let skillCell = cell as? SkillInputCell,
           let skillItem = resumeContext.skills[safe: indexPath.row] {
            skillCell.set(skill: skillItem.title)
        }

        if theSection == .educations,
           let eduCell = cell as? EducationInputCell,
           let eduItem = resumeContext.educations[safe: indexPath.row] {
            eduCell.set(class: eduItem.class, year: eduItem.endYear, gpa: eduItem.gpa)
        }

        if theSection == .projects,
           let projCell = cell as? ProjectInputCell,
           let projItem = resumeContext.projects[safe: indexPath.row] {
            projCell.set(title: projItem.name, teamSize: projItem.teamSize, summary: projItem.summary, techUsed: projItem.techUsed, role: projItem.role)
        }

        return cell
    }

    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let theSection = sections[indexPath.section]
        switch theSection {
        case .info:
            if indexPath.row == 2 {
                return Builder.CellType.textView.cellHeight
            } else {
                return Builder.CellType.textField.cellHeight
            }
        default: return theSection.cellHeight
        }
    }

    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}
