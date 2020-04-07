//
//  ViewController.swift
//  CTSAssignment
//  Showing all fetched data from drop list api
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import UIKit

/// This class fetch all data from dropbox api and it will display in list view
class ListViewController: UIViewController {
    
    /// variable for tableview datasource which will responsible for creating list and displaying data in list each cell
  private var dataSource = ListDataSource()
  private let refreshControl = UIRefreshControl() /// declaration for pull to refresh
    
    /// creating view model which is handaling all business logic
  private lazy var viewModel : ListViewModel = {
        let viewModel = ListViewModel(service: FactListService(), dataSource: dataSource)
        return viewModel
    }()
    /// IInitilisation of tableview and setting estamated height for each cell
    var tableView : UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .white
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    /// view controller lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUi()
        self.addingObserver()
        self.observerError()
    }

    override func viewWillAppear(_ animated: Bool) {
        refreshTable()
    }
    
    /// Setting initial setup view which is going to be called when view going to load into memory
    func setupUi()  {
        self.view.addSubview(tableView) // Adding tableview in controller view
        self.setupAutoLayout()
        self.tableView.dataSource = self.dataSource
            // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged) // Adding selecter when uer pull table to refresh list , this will call refresh table function
    }
    
    /// Setting Autolayout constraints programatically  for table view or list view
    func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    /// Adding a observer  Which is going to notified when new data is available and this closers going to populate or refresh our tableview or list
    func addingObserver(){
    self.dataSource.data.addAndNotify(observer: self) { [weak self ] _ in
        self?.tableView.reloadData()
        self?.refreshControl.endRefreshing()
     }
        /// setting a listener for setting a title on navbar
       self.viewModel.messagePassing = { title in
            self.title = title
        }
    }
    
    /// Handaling all error which we triggered from our view model  (business logic)
    func observerError()  {
        // add error handling example
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
    }
    
    /// Selecter for refresing Listview or tableview
   @objc func refreshTable()  {
        self.viewModel.fetchList()
    }

}

