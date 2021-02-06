//
//  ViewController.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 02/02/2021.
//

import UIKit

class ContactListViewController: UIViewController {

    // contact reuse identifier
    private let contactCellReuseIdentifier: String = "contactCell"
    
    // TableView Containing the Contact Cell
    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(ContactTableViewCell.self, forCellReuseIdentifier: contactCellReuseIdentifier)
        tableview.rowHeight = 150
        return tableview
    }()
    
    private var contactManager: ContactManager = ContactManager()
    
    // Called when view is fully loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "People"
        
        contactManager.downloadContacts { [weak self] (isDownloadSuccess) in
            if isDownloadSuccess {
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            } else {
                // fetch coredata last session
            }
        }
        
    }
    
    // Adding the views and customize them
    // set the delegates here
    override func loadView() {
        super.loadView()
        
        /* Add view's subviews here */
        tableview.delegate = self
        tableview.dataSource = self
        tableview.prefetchDataSource = self
        view.addSubview(tableview)
        
        self.setConstraints()
    }
    
    // Creating constraints
    private func setConstraints() {
        
        // Customize with size class
        switch (UIScreen.main.traitCollection.horizontalSizeClass, UIScreen.main.traitCollection.verticalSizeClass) {
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
            break
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
            break
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            break
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
            break
        default:
            break
        }
        
        // Customize constraints for size class (every, every)
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

// MARK: UITableViewDelegate
extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: UITableViewDataSource
extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactManager.resquests.compactMap { $0.results.count }.reduce(0, +)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactTableViewCell(style: .default, reuseIdentifier: contactCellReuseIdentifier)
        return cell
    }
}

// MARK: UITableViewDataSourcePrefetching
extension ContactListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    }
}

