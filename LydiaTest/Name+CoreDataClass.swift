//
//  Name+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(Name)
public class Name: NSManagedObject, Codable {
    
    enum CodingKeys: CodingKey {
        case title
        case first
        case last
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.first = try container.decode(String.self, forKey: .first)
        self.last = try container.decode(String.self, forKey: .last)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(first, forKey: .first)
        try container.encode(last, forKey: .last)
    }
}
