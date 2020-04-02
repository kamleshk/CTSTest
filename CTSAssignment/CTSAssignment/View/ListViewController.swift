//
//  ViewController.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var tableView : UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .white
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    var dataSource = ListDataSource()
   lazy var viewModel : ListViewModel = {
        let viewModel = ListViewModel(service: FactListService(), dataSource: dataSource)
        return viewModel
    }()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUi()
        self.addingObserver()
        self.observerError()
        self.viewModel.fetchCurrencies()
    }

    
    func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupUi()  {
        self.view.addSubview(tableView)
        self.setupAutoLayout()
        self.tableView.dataSource = self.dataSource
    }
    // ading listiner for data modification
    func addingObserver(){
    self.dataSource.data.addAndNotify(observer: self) { [weak self ] _ in
        self?.tableView.reloadData()
     }
    }
    
    func observerError()  {
        // add error handling example
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
    }

}

