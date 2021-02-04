//
//  ViewController.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 02/02/2021.
//

import UIKit

class ContactListViewController: UIViewController {

    // Tableview containing the contact cell
    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
//        tableview.register(PostTableViewCell.self, forCellReuseIdentifier: "contactCell")
        tableview.rowHeight = 200
        tableview.backgroundColor = .orange
        return tableview
    }()
    
    // Called when view is fully loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "People"     
    }
    
    // Adding the views and customize them
    // set the delegates here
    override func loadView() {
        super.loadView()
        
        /* Add view's subviews here */
        
        self.setConstraints()
    }
    
    // Creating constraints
    private func setConstraints() {
        
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
        
    }


}

