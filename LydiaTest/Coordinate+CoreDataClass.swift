//
//  Coordinate+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(Coordinate)
public class Coordinate: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case longitude
        case latitude
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.longitude = try container.decode(String.self, forKey: .longitude)
        self.latitude = try container.decode(String.self, forKey: .latitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
    }
}
