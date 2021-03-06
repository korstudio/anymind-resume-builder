//
//  ResumeListViewController.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 21/3/22.
//  Copyright (c) 2022 Methas Tariya. All rights reserved.
//

import UIKit

protocol ResumeListDisplayLogic: AnyObject {
    func displayResumeList(viewModel: ResumeList.Display.ViewModel)
}

class ResumeListViewController: UITableViewController {
    // @IBOutlet var

    var interactor: ResumeListBusinessLogic?
    var router: (NSObjectProtocol & ResumeListRoutingLogic & ResumeListDataPassing)?
    
    var resumeList: [ResumeList.ResumeContext] = []

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Style.applyNavStyles(of: navigationController, color: .yellow)
        interactor?.loadSavedResume()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func onNewTapped(_ sender: UIBarButtonItem) {
        router?.routeToBuilder()
    }
}

extension ResumeListViewController: ResumeListDisplayLogic {
    func displayResumeList(viewModel: ResumeList.Display.ViewModel) {
        resumeList = viewModel.resumeList
        tableView.reloadData()
    }
}

extension ResumeListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resumeList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: String(type: ResumeItemCell.self), for: indexPath)
        
        if let cell = tableCell as? ResumeItemCell,
            let resumeItem = resumeList[safe: indexPath.row] {
            cell.set(title: resumeItem.title, date: resumeItem.date)
        }
        
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let resume = resumeList[safe: indexPath.row] else { return }
        router?.routeToBuilder(with: resume)
    }
}
