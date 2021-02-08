//
//  Id+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(Id)
public class Id: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case name
        case value
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String?.self, forKey: .value)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(value, forKey: .value)
    }
}
