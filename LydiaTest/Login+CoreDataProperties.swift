//
//  Login+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension Login {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Login> {
        return NSFetchRequest<Login>(entityName: "Login")
    }

    @NSManaged public var md5: String
    @NSManaged public var password: String
    @NSManaged public var salt: String
    @NSManaged public var sha1: String
    @NSManaged public var sha256: String
    @NSManaged public var username: String
    @NSManaged public var uuid: String
    @NSManaged public var contact: Contact?

}

extension Login : Identifiable {

}
