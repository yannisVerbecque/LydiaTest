//
//  ViewController.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 02/02/2021.
//

import UIKit
import CoreData

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
    private let cache = NSCache<NSString, UIImage>()
    
    // Called when view is fully loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "People"
        
        PersistentContainer.shared.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
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
            } else {
                // fetch coredata last session saved
                let request = ContactRequest.createFetchRequest()
                do {
                    self?.contactManager.resquests = try PersistentContainer.shared.viewContext.fetch(request)
                } catch {
                    print("Fetching failed")
                }
            }
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
    }


}

// MARK: UITableViewDelegate
extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactDetailViewController = ContactDetailViewController()
        contactDetailViewController.contact = self.contactManager.getContactAtIndexPath(indexPath)
        self.navigationController?.pushViewController(contactDetailViewController, animated: true)
    }
}

// MARK: UITableViewDataSource
extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactManager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactTableViewCell(style: .default, reuseIdentifier: contactCellReuseIdentifier)
        cell.cache = cache
        cell.contact = self.contactManager.getContactAtIndexPath(indexPath)
        return cell
    }
}

// MARK: UITableViewDataSourcePrefetching
extension ContactListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        /*
         * Caching UIImage for fast tableview load time
         */
        for indexPath in indexPaths {
            guard let contact = self.contactManager.getContactAtIndexPath(indexPath) else { return }
            let largePictureString = contact.picture.large
            if let url = URL(string: largePictureString) {
                // if the uiimage isn't cache
                if (cache.object(forKey: largePictureString as NSString) == nil) {
                    // download the image on a queue
                    DispatchQueue.global().async { [weak self] in
                        // Fetch Image Data
                        if let data = try? Data(contentsOf: url) {
                            // Create Image and Update Image View
                            if let uiimg = UIImage(data: data) {
                                self?.cache.setObject(uiimg, forKey: largePictureString as NSString)
                            }
                        }
                    }
                }
            }
        }
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
