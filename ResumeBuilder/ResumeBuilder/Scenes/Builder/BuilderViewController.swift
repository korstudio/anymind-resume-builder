//
//  BuilderViewController.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Gallery
import CropViewController
import Toast_Swift

protocol BuilderDisplayLogic: AnyObject {
    func displayResume(viewModel: Builder.GetResume.ViewModel)
    func displaySaveCompleted(viewModel: Builder.Save.ViewModel)
    func updateValue(with value: DisplayValue)
}

class BuilderViewController: UITableViewController {
    var interactor: BuilderBusinessLogic?
    var router: (NSObjectProtocol & BuilderRoutingLogic & BuilderDataPassing)?

    var sections: [Builder.Section] = []
    var resumeContext: Builder.ResumeContext = .init()

    lazy var galleryCtrl = GalleryController()

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    static func create() -> BuilderViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BuilderViewController") as? BuilderViewController
        return vc
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
        galleryCtrl.delegate = self
        Gallery.Config.tabsToShow = [.imageTab, .cameraTab]
        Gallery.Config.initialTab = .imageTab
        Gallery.Config.Camera.imageLimit = 1
        
        ToastManager.shared.isTapToDismissEnabled = true

        Style.applyNavStyles(of: navigationController, color: .blue)
        interactor?.getResumeAndDisplay(request: .init())
    }
    
    @IBAction func onClose(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func onSavePDF(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        interactor?.save(request: .init(context: resumeContext))
    }
}

extension BuilderViewController: BuilderDisplayLogic {
    func displayResume(viewModel: Builder.GetResume.ViewModel) {
        sections = viewModel.sections
        resumeContext = viewModel.context
        tableView.reloadData()
    }
    
    func displaySaveCompleted(viewModel: Builder.Save.ViewModel) {
        var style = ToastStyle()
        style.cornerRadius = 16
        style.shadowColor = .clear
        style.displayShadow = false
        style.backgroundColor = viewModel.hasError ? .error : .appGreen
        style.titleFont = Style.Font.museoRoundedBlack(16).font
        style.messageFont = Style.Font.museoRoundedBold(16).font
        style.titleColor = .white
        style.messageColor = .white
        style.titleAlignment = .center
        style.messageAlignment = .center
        
        view.makeToast(viewModel.hasError ? "Save error" : "Save successful", duration: 2, position: .top, style: style)
    }

    func updateValue(with value: DisplayValue) {
        switch value.section {
        case .info where value.index == 0:
            resumeContext.mobile = value.content.get(.text)
        case .info where value.index == 1:
            resumeContext.email = value.content.get(.text)
        case .info where value.index == 2:
            resumeContext.address = value.content.get(.text)
        case .career:
            resumeContext.careerObj = value.content.get(.text)
        case .yearsExp:
            resumeContext.years = value.content.get(.text)
        case .works:
            resumeContext[.works, at: value.index] = value.content
        case .skills:
            resumeContext[.skills, at: value.index] = value.content
        case .educations:
            resumeContext[.educations, at: value.index] = value.content
        case .projects:
            resumeContext[.projects, at: value.index] = value.content
        default: break
        }
    }
}

extension BuilderViewController {
    public override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let theSection = sections[section]
        switch theSection {
        case .works: return resumeContext.works.count + 1
        case .skills: return resumeContext.skills.count + 1
        case .educations: return resumeContext.educations.count + 1
        case .projects: return resumeContext.projects.count + 1
        default: return theSection.rowCount
        }
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theSection = sections[indexPath.section]
        let cellType = getCellType(at: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: String(type: cellType), for: indexPath)

        if theSection == .photo,
           let photoCell = cell as? ImageCell {
            photoCell.delegate = self
            
            if let photoData = resumeContext.photoData {
                photoCell.set(image: .init(data: photoData))
            }
        }

        if theSection == .info {
            switch indexPath.row {
            case 0:
                let textCell = cell as? TextFieldCell
                textCell?.assign(view: self, section: theSection, indexPath: indexPath)
                textCell?.set(title: Builder.Section.mobile.cells.title, text: resumeContext.mobile)
            case 1:
                let textCell = cell as? TextFieldCell
                textCell?.assign(view: self, section: theSection, indexPath: indexPath)
                textCell?.set(title: Builder.Section.email.cells.title, text: resumeContext.email)
            case 2:
                let textViewCell = cell as? TextViewCell
                textViewCell?.assign(view: self, section: theSection, indexPath: indexPath)
                textViewCell?.set(title: Builder.Section.address.cells.title, text: resumeContext.address)
            default: break
            }
        }

        if theSection == .career {
            let title = theSection.cells.title
            let textCell = cell as? TextFieldCell
            textCell?.assign(view: self, section: theSection, indexPath: indexPath)
            textCell?.set(title: title, text: resumeContext.careerObj)
        }

        if theSection == .yearsExp {
            let title = theSection.cells.title
            let textCell = cell as? TextFieldCell
            textCell?.assign(view: self, section: theSection, indexPath: indexPath)
            textCell?.set(title: title, text: resumeContext.years)
        }

        if theSection == .works,
           let workCell = cell as? WorkInputCell,
           let workItem = resumeContext.works[safe: indexPath.row] {
            workCell.assign(view: self, section: theSection, indexPath: indexPath)
            workCell.set(company: workItem.companyName, duration: workItem.duration)
        }

        if theSection == .skills,
           let skillCell = cell as? SkillInputCell,
           let skillItem = resumeContext.skills[safe: indexPath.row] {
            skillCell.assign(view: self, section: theSection, indexPath: indexPath)
            skillCell.set(skill: skillItem.title)
        }

        if theSection == .educations,
           let eduCell = cell as? EducationInputCell,
           let eduItem = resumeContext.educations[safe: indexPath.row] {
            eduCell.assign(view: self, section: theSection, indexPath: indexPath)
            eduCell.set(class: eduItem.class, year: eduItem.endYear, gpa: eduItem.gpa)
        }

        if theSection == .projects,
           let projCell = cell as? ProjectInputCell,
           let projItem = resumeContext.projects[safe: indexPath.row] {
            projCell.assign(view: self, section: theSection, indexPath: indexPath)
            projCell.set(title: projItem.name, teamSize: projItem.teamSize, summary: projItem.summary, techUsed: projItem.techUsed, role: projItem.role)
        }

        if let addCell = cell as? AddRowCell {
            addCell.indexPath = indexPath
            addCell.section = theSection
            addCell.delegate = self
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
        case .works where isLast(indexPath.row, of: .works),
             .skills where isLast(indexPath.row, of: .skills),
             .educations where isLast(indexPath.row, of: .educations),
             .projects where isLast(indexPath.row, of: .projects):
            return Builder.CellType.addRow.cellHeight
        default: return theSection.cellHeight
        }
    }

    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return nil }
        return sections[section].title
    }

    private func getCellType(at indexPath: IndexPath) -> UITableViewCell.Type {
        let section = sections[indexPath.section]
        let cellType: UITableViewCell.Type
        switch section {
        case .photo:
            cellType = ImageCell.self
        case .info where indexPath.row == 2:
            cellType = TextViewCell.self
        case .works:
            if isLast(indexPath.row, of: .works) {
                cellType = AddRowCell.self
            } else {
                cellType = WorkInputCell.self
            }
        case .skills:
            if isLast(indexPath.row, of: .skills) {
                cellType = AddRowCell.self
            } else {
                cellType = SkillInputCell.self
            }
        case .educations:
            if isLast(indexPath.row, of: .educations) {
                cellType = AddRowCell.self
            } else {
                cellType = EducationInputCell.self
            }
        case .projects:
            if isLast(indexPath.row, of: .projects) {
                cellType = AddRowCell.self
            } else {
                cellType = ProjectInputCell.self
            }
        default:
            cellType = TextFieldCell.self
        }

        return cellType
    }

    private func isLast(_ row: Int, of section: Builder.Section) -> Bool {
        switch section {
        case .works: return row == resumeContext.works.endIndex
        case .skills: return row == resumeContext.skills.endIndex
        case .educations: return row == resumeContext.educations.endIndex
        case .projects: return row == resumeContext.projects.endIndex
        default: return false
        }
    }
}

extension BuilderViewController: AddRowCellDelegate {
    func addRowButtonDidTap(for section: Builder.Section, at indexPath: IndexPath) {
        let count: Int
        switch section {
        case .works:
            resumeContext.works.append(.init())
            count = resumeContext.works.count
        case .skills:
            resumeContext.skills.append(.init())
            count = resumeContext.skills.count
        case .educations:
            resumeContext.educations.append(.init())
            count = resumeContext.educations.count
        case .projects:
            resumeContext.projects.append(.init())
            count = resumeContext.projects.count
        default:
            count = 0
        }

        tableView.insertRows(at: [.init(row: count - 1, section: indexPath.section)], with: .bottom)
    }
}

extension BuilderViewController: ImageCellDelegate {
    func imageCellDidTapOnImageView() {
        present(galleryCtrl, animated: true)
    }
}

extension BuilderViewController: GalleryControllerDelegate {
    public func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        guard let imageAsset = images.first else { return }
        imageAsset.resolve { [weak self] image in
            guard let image = image else { return }
            self?.callCropViewController(image: image)
        }
    }

    public func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {

    }

    public func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {

    }

    public func galleryControllerDidCancel(_ controller: GalleryController) {
        
    }

    private func callCropViewController(image: UIImage) {
        let cropCtrl = CropViewController(image: image)
        cropCtrl.aspectRatioPreset = .presetSquare
        cropCtrl.delegate = self
        DispatchQueue.main.async { [weak self] in
            self?.galleryCtrl.dismiss(animated: true)
            self?.present(cropCtrl, animated: true)
        }
    }
}

extension BuilderViewController: CropViewControllerDelegate {
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        resumeContext[.photo] = image.pngData()
        cropViewController.dismiss(animated: true)
        tableView.reloadData()
    }
}
