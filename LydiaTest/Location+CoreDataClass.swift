//
//  Location+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case street
        case city
        case state
        case country
        case postcode
        case coordinates
        case timezone
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        do {
            postcode = try container.decode(String.self, forKey: .postcode)
        } catch DecodingError.typeMismatch {
            let nombre = try container.decode(Int.self, forKey: .postcode)
            postcode = nombre.description
        } catch {
            postcode = "error decoding"
        }
        coordinates = try container.decode(Coordinate.self, forKey: .coordinates)
        timezone = try container.decode(Timezone.self, forKey: .timezone)

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
        try container.encode(country, forKey: .country)
        try container.encode(postcode, forKey: .postcode)
        try container.encode(coordinates, forKey: .coordinates)
        try container.encode(timezone, forKey: .timezone)
        
    }
}
