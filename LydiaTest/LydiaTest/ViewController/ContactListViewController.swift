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
    private var isLoadingData: Bool = false
    
    // Called when view is fully loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "People"
        
        self.downloadTenContact()
        
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
        
        /* Add constraints */
        self.setConstraints()
    }
    
    // Creating constraints
    private func setConstraints() {
        
        // Customize with size class
        switch (UIScreen.main.traitCollection.horizontalSizeClass, UIScreen.main.traitCollection.verticalSizeClass) {
            // small screen sizes
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
            break
            // portrait iphone or portrait split view
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
            break
            // ipad or 4:3 split view
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            break
            // landscape iphone 
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
            break
        default:
            break
        }
        
        // Customize constraints for every size class (every, every)
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func downloadTenContact() -> Void {
        self.isLoadingData = true
        contactManager.downloadContacts { [weak self] (isDownloadSuccess) in
            if isDownloadSuccess {
                self?.isLoadingData = false
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            } else {
                // fetch coredata last session saved
            }
        }
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
        return self.contactManager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactTableViewCell(style: .default, reuseIdentifier: contactCellReuseIdentifier)
        cell.contact = self.contactManager.getContactAtIndexPath(indexPath)
        return cell
    }
}

// MARK: UITableViewDataSourcePrefetching
extension ContactListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    }
}

// MARK: UIScrollViewDelegate inherited from the tableview
extension ContactListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset: CGFloat = scrollView.contentOffset.y
        let contentHeight: CGFloat = scrollView.contentSize.height
        if (yOffset > contentHeight - scrollView.frame.height) && !isLoadingData {
            self.downloadTenContact()
        }
    }
}
