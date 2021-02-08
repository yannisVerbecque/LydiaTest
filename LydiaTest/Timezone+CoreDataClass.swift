//
//  Timezone+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(Timezone)
public class Timezone: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case offset
        case detail = "description"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try container.decode(String.self, forKey: .offset)
        self.detail = try container.decode(String.self, forKey: .detail)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(offset, forKey: .offset)
        try container.encode(detail, forKey: .detail)
    }
}
