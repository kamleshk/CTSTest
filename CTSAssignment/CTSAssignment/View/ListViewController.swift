//
//  ViewController.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

   
    
   var dataSource = ListDataSource()
   lazy var viewModel : ListViewModel = {
        let viewModel = ListViewModel(service: FactListService(), dataSource: dataSource)
        return viewModel
    }()
    
    private let refreshControl = UIRefreshControl()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUi()
        self.addingObserver()
        self.observerError()
    }

    override func viewWillAppear(_ animated: Bool) {
        refreshTable()
    }
    // Autolayout constraints function
    func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    // seeting up uitableview
    var tableView : UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .white
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    // ui setup function
    func setupUi()  {
        self.view.addSubview(tableView)
        self.setupAutoLayout()
        self.tableView.dataSource = self.dataSource
            // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged)
    }
    // ading listiner for data modification
    func addingObserver(){
    self.dataSource.data.addAndNotify(observer: self) { [weak self ] _ in
        self?.tableView.reloadData()
        self?.refreshControl.endRefreshing()
     }
        
        self.viewModel.messagePassing = { title in
            self.title = title
        }
    }
    
    // adding error observer
    func observerError()  {
        // add error handling example
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
    }
   @objc func refreshTable()  {
        self.viewModel.fetchList()
    }

}

