//
//  ContactTableViewCell.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 04/02/2021.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var contact: Contact? {
        didSet {
            if let contact = contact {
                setContact(contact)
            }
        }
    }
    
    var contactImageView: UIImageView = UIImageView(frame: .zero)
    var firstlastLabel: UILabel = UILabel(frame: .zero)
    var nationalityLabel: UILabel = UILabel(frame: .zero)
    let margin: CGFloat = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.layer.cornerCurve = .circular
        contactImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        contactImageView.layer.shadowColor = UIColor.black.cgColor
        contactImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contactImageView.layer.shadowRadius = 10
        contactImageView.layer.borderColor = UIColor.red.cgColor
        contactImageView.layer.borderWidth = 2
        contactImageView.layer.cornerRadius = contactImageView.frame.width/2
        contactImageView.clipsToBounds = true
        contentView.addSubview(contactImageView)
        
        firstlastLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(firstlastLabel)
        
        nationalityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nationalityLabel)
        
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: self.margin),
            contactImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -self.margin),
            contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: self.margin),
            contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
            firstlastLabel.bottomAnchor.constraint(equalTo: contactImageView.centerYAnchor, constant: -self.margin/2),
            firstlastLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: self.margin/2),
            firstlastLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -self.margin/2),
            firstlastLabel.heightAnchor.constraint(equalToConstant: 20),
            nationalityLabel.topAnchor.constraint(equalTo: contactImageView.centerYAnchor, constant: self.margin/2),
            nationalityLabel.leadingAnchor.constraint(equalTo: firstlastLabel.leadingAnchor),
            nationalityLabel.trailingAnchor.constraint(equalTo: firstlastLabel.trailingAnchor),
            nationalityLabel.heightAnchor.constraint(equalTo: firstlastLabel.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Populate the cell with data
    func setContact(_ contact: Contact) {}
}
