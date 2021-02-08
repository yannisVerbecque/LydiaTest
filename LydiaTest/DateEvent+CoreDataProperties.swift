//
//  DateEvent+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension DateEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateEvent> {
        return NSFetchRequest<DateEvent>(entityName: "DateEvent")
    }

    @NSManaged public var age: Int16
    @NSManaged public var date: String
    @NSManaged public var contact: Contact?
    @NSManaged public var contact2: Contact?

}

extension DateEvent : Identifiable {

}
