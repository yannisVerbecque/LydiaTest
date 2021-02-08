//
//  Contact+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var cell: String
    @NSManaged public var email: String
    @NSManaged public var gender: String
    @NSManaged public var nat: String
    @NSManaged public var phone: String
    @NSManaged public var contactRequest: ContactRequest?
    @NSManaged public var dob: DateEvent
    @NSManaged public var id: Id
    @NSManaged public var location: Location
    @NSManaged public var login: Login
    @NSManaged public var name: Name
    @NSManaged public var picture: PictureLink
    @NSManaged public var registered: DateEvent

}

extension Contact : Identifiable {

}
