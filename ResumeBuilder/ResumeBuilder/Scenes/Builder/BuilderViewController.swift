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
