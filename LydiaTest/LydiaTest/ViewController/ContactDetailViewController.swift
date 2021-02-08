//
//  ContactDetailViewController.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 07/02/2021.
//

import Foundation
import UIKit
import MapKit

class ContactDetailViewController: UIViewController, Contactable {
    
    var contact: Contact? {
        didSet {
            if let contact = contact {
                setContact(contact)
            }
        }
    }
    
    private var scrollview: UIScrollView = UIScrollView(frame: .zero)
    private var fullNameLabel: UILabel = UILabel(frame: .zero)
    private var genderLabel: UILabel = UILabel(frame: .zero)
    private var adressLabel: UILabel = UILabel(frame: .zero)
    private var adressCityStateLabel: UILabel = UILabel(frame: .zero)
    private var countryLabel: UILabel = UILabel(frame: .zero)
    private var mapView: MKMapView = MKMapView(frame: .zero)
    private var timezoneTimeLabel: UILabel = UILabel(frame: .zero)
    private var emailLabel: UILabel = UILabel(frame: .zero)
    private var dateOfBirthLabel: UILabel = UILabel(frame: .zero)
    private var dateOfRegistrationLabel: UILabel = UILabel(frame: .zero)
    private var phoneLabel: UILabel = UILabel(frame: .zero)
    private var cellPhoneLabel: UILabel = UILabel(frame: .zero)
    private var nationalityLabel: UILabel = UILabel(frame: .zero)
    private var fullIDLabel: UILabel = UILabel(frame: .zero)
    private var imageView: UIImageView = UIImageView(frame: .zero)
    private var firstStackView: UIStackView = UIStackView(frame: .zero)
    private var secondStackView: UIStackView = UIStackView(frame: .zero)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func loadView() {
        super.loadView()
        
        // scrollview
        self.scrollview.translatesAutoresizingMaskIntoConstraints = false
        self.scrollview.isScrollEnabled = true
        self.view.addSubview(self.scrollview)
        
        // imageview
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.backgroundColor = .gray
        self.imageView.layer.cornerRadius = 15
        self.imageView.layer.cornerCurve = .continuous
        self.imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.imageView.clipsToBounds = true
        self.scrollview.addSubview(self.imageView)
        
        // first stack containing
        // full name
        // age
        // gender
        // nationality
        // adress
        self.firstStackView.translatesAutoresizingMaskIntoConstraints = false
        self.firstStackView.alignment = .leading
        self.firstStackView.distribution = .equalSpacing
        self.firstStackView.axis = .vertical
        self.firstStackView.spacing = 4
        self.firstStackView.addArrangedSubview(self.fullNameLabel)
        self.firstStackView.addArrangedSubview(self.dateOfBirthLabel)
        self.firstStackView.addArrangedSubview(self.genderLabel)
        self.firstStackView.addArrangedSubview(self.nationalityLabel)
        self.firstStackView.addArrangedSubview(self.adressLabel)
        self.firstStackView.addArrangedSubview(self.adressCityStateLabel)
        self.firstStackView.addArrangedSubview(self.countryLabel)
        self.scrollview.addSubview(self.firstStackView)
        
        // mapview
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.isScrollEnabled = false
        self.mapView.layer.cornerRadius = 15
        self.mapView.layer.cornerCurve = .continuous
        self.mapView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.scrollview.addSubview(self.mapView)
        
        self.secondStackView.translatesAutoresizingMaskIntoConstraints = false
        self.secondStackView.alignment = .leading
        self.secondStackView.distribution = .equalSpacing
        self.secondStackView.axis = .vertical
        self.secondStackView.spacing = 4
        self.secondStackView.addArrangedSubview(self.timezoneTimeLabel)
        self.secondStackView.addArrangedSubview(self.phoneLabel)
        self.secondStackView.addArrangedSubview(self.cellPhoneLabel)
        self.secondStackView.addArrangedSubview(self.emailLabel)
        self.secondStackView.addArrangedSubview(self.dateOfRegistrationLabel)
        self.secondStackView.addArrangedSubview(self.fullIDLabel)
        self.scrollview.addSubview(self.secondStackView)

        self.setConstraints()
    }
    
    private func setConstraints() -> Void {
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalTo: scrollview.widthAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            self.firstStackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 16),
            self.firstStackView.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.firstStackView.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 8),
            self.mapView.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 16),
            self.mapView.heightAnchor.constraint(equalToConstant: 250),
            self.secondStackView.topAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: 8),
            self.secondStackView.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.secondStackView.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            self.secondStackView.bottomAnchor.constraint(equalTo: self.scrollview.bottomAnchor),
        ])
    }

    func setContact(_ contact: Contact) -> Void {
        title = "\(contact.name.first) \(contact.name.last)"
        
        self.fullNameLabel.text = "\(contact.name.title) \(contact.name.first) \(contact.name.last)"
        self.dateOfBirthLabel.text = "\(contact.dob.age) years old"
        self.genderLabel.text = "\(contact.gender.capitalized)"
        self.nationalityLabel.text = "Nationality: \(NSLocale.system.localizedString(forLanguageCode: contact.nat) ?? contact.nat)"
        self.adressLabel.text = "\(contact.location.street.number) \(contact.location.street.name)"
        self.adressCityStateLabel.text = "\(contact.location.city), \(contact.location.state), \(contact.location.postcode)"
        self.countryLabel.text = "Lives in \(contact.location.country)"
        
        //
        //  Latitude and Longitude generated by API DOESN'T correspond to any place
        //  Randomized by API
        //
        if let latitude = CLLocationDegrees(Substring.init(contact.location.coordinates.latitude)),
           let longitude = CLLocationDegrees(Substring.init(contact.location.coordinates.longitude)) {
            self.mapView.region.span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.03), longitudeDelta: CLLocationDegrees(0.03))
            self.mapView.region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        if let imageURL = URL(string: contact.picture.large) {
            do {
                let data: Data = try Data(contentsOf: imageURL)
                self.imageView.image = UIImage(data: data)
            } catch {
            }
        }
        
        self.timezoneTimeLabel.text = "\(contact.location.timezone.detail)"
        self.phoneLabel.text = "Phone: \(contact.phone)"
        self.cellPhoneLabel.text = "Cellphone: \(contact.cell)"
        self.emailLabel.text = "Email: \(contact.email)"
        self.dateOfRegistrationLabel.text = "Register date: \(contact.registered.age) ago"
        self.fullIDLabel.text = "ID: \(contact.id.name) \(contact.id.value ?? "")"

        
    }

}
