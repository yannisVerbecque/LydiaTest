//
//  Info+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(Info)
public class Info: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case seed
        case results
        case page
        case version
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.seed = try container.decode(String.self, forKey: .seed)
        self.version = try container.decode(String.self, forKey: .version)
        self.page = try container.decode(Int16.self, forKey: .page)
        self.results = try container.decode(Int16.self, forKey: .results)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(seed, forKey: .seed)
        try container.encode(results, forKey: .results)
        try container.encode(page, forKey: .page)
        try container.encode(version, forKey: .version)
    }
    
}
