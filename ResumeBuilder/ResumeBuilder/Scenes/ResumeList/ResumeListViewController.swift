//
//  ResumeListViewController.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit

protocol ResumeListDisplayLogic: AnyObject {}

class ResumeListViewController: UITableViewController {
    // @IBOutlet var

    var interactor: ResumeListBusinessLogic?
    var router: (NSObjectProtocol & ResumeListRoutingLogic & ResumeListDataPassing)?

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
        let interactor = ResumeListInteractor()
        let presenter = ResumeListPresenter()
        let router = ResumeListRouter()
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
        Style.applyNavStyles(of: navigationController, color: .yellow)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func onNewTapped(_ sender: UIBarButtonItem) {
        router?.routeToBuilder()
    }
}

extension ResumeListViewController: ResumeListDisplayLogic {}

extension ResumeListViewController {
//    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        super.tableView(tableView, cellForRowAt: indexPath)
//    }
}
