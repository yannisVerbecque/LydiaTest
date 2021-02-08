//
//  ContactTableViewCell.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 04/02/2021.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell, Contactable {
    
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
    var cache: NSCache<NSString, UIImage>? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.layer.cornerCurve = .circular
        contactImageView.layer.cornerRadius = 30
        contactImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        contactImageView.layer.shadowColor = UIColor.black.cgColor
        contactImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contactImageView.layer.shadowRadius = 10
        contactImageView.layer.borderColor = #colorLiteral(red: 0.3682169616, green: 0.6884049177, blue: 1, alpha: 1).cgColor
        contactImageView.layer.borderWidth = 3
        contactImageView.clipsToBounds = true
        contentView.addSubview(contactImageView)
        
        firstlastLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(firstlastLabel)
        
        nationalityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nationalityLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() -> Void {
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: self.margin),
            contactImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -self.margin),
            contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: self.margin),
            contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
            firstlastLabel.bottomAnchor.constraint(equalTo: contactImageView.centerYAnchor, constant: -self.margin/4),
            firstlastLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: self.margin/2),
            firstlastLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -self.margin/2),
            firstlastLabel.heightAnchor.constraint(equalToConstant: 20),
            nationalityLabel.topAnchor.constraint(equalTo: contactImageView.centerYAnchor, constant: self.margin/4),
            nationalityLabel.leadingAnchor.constraint(equalTo: firstlastLabel.leadingAnchor),
            nationalityLabel.trailingAnchor.constraint(equalTo: firstlastLabel.trailingAnchor),
            nationalityLabel.heightAnchor.constraint(equalTo: firstlastLabel.heightAnchor),
        ])
    }
    
    // Populate the cell with data
    func setContact(_ contact: Contact) {
        firstlastLabel.text = "\(contact.name.first) \(contact.name.last)"
        nationalityLabel.text = "\(NSLocale.system.localizedString(forRegionCode: contact.nat) ?? contact.nat)"
        
        // Downloading the large image
        guard let imgURL = URL(string: contact.picture.large), let imgData = try? Data(contentsOf: imgURL) else { return }
        // if a cached version is available
        if let cachedVersion = self.cache?.object(forKey: contact.picture.large as NSString) {
            // use the cached version
            self.contactImageView.image = cachedVersion
        } else {
            DispatchQueue.global().async {
                // create it from scratch by
                // Downloading the images on a queue
                if let uiimg = UIImage(data: imgData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.contactImageView.image = uiimg
                        // then store in the cache
                        self?.cache?.setObject(uiimg, forKey: contact.picture.large as NSString)
                    }
                }
            }
        }
    }
}
