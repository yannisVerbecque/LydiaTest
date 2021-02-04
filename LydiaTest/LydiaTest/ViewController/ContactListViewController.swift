//
//  ViewController.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 02/02/2021.
//

import UIKit

class ContactListViewController: UIViewController {

    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
//        tableview.register(PostTableViewCell.self, forCellReuseIdentifier: "contactCell")
        tableview.rowHeight = 200
        tableview.backgroundColor = .orange
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "People"     
    }
    
    // Adding the views and customize them
    override func loadView() {
        super.loadView()
    }


}

