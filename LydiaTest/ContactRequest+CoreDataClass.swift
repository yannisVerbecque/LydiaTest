//
//  ContactRequest+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(ContactRequest)
public class ContactRequest: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case results
        case info
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode(Set<Contact>.self, forKey: .results) as NSSet
        self.info = try container.decode(Info.self, forKey: .info)

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results as! Set<Contact>, forKey: .results)
        try container.encode(info, forKey: .info)
    }
}
