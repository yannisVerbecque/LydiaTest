//
//  PictureLink+CoreDataProperties.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData


extension PictureLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureLink> {
        return NSFetchRequest<PictureLink>(entityName: "PictureLink")
    }

    @NSManaged public var large: String
    @NSManaged public var medium: String
    @NSManaged public var thumbnail: String
    @NSManaged public var contact: Contact?

}

extension PictureLink : Identifiable {

}
