//
//  ContactRequest+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension ContactRequest {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<ContactRequest> {
        return NSFetchRequest<ContactRequest>(entityName: "ContactRequest")
    }

    @NSManaged public var info: Info
    @NSManaged public var results: NSSet

}

// MARK: Generated accessors for results
extension ContactRequest {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: Contact)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: Contact)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}

extension ContactRequest : Identifiable {

}
