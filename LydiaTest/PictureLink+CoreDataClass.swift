//
//  PictureLink+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(PictureLink)
public class PictureLink: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case large
        case medium
        case thumbnail
    }
    
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.large = try container.decode(String.self, forKey: .large)
        self.medium = try container.decode(String.self, forKey: .medium)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(large, forKey: .large)
        try container.encode(medium, forKey: .medium)
        try container.encode(thumbnail, forKey: .thumbnail)
    }
}
