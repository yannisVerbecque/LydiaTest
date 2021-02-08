//
//  Contact+CoreDataClass.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 08/02/2021.
//
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case gender
        case name
        case location
        case email
        case login
        case dob
        case registered
        case phone
        case cell
        case id
        case picture
        case nat
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.name = try container.decode(Name.self, forKey: .name)
        self.location = try container.decode(Location.self, forKey: .location)
        self.email = try container.decode(String.self, forKey: .email)
        self.login = try container.decode(Login.self, forKey: .login)
        self.dob = try container.decode(DateEvent.self, forKey: .dob)
        self.registered = try container.decode(DateEvent.self, forKey: .registered)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.cell = try container.decode(String.self, forKey: .cell)
        self.id = try container.decode(Id.self, forKey: .id)
        self.picture = try container.decode(PictureLink.self, forKey: .picture)
        self.nat = try container.decode(String.self, forKey: .nat)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gender, forKey: .gender)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(email, forKey: .email)
        try container.encode(login, forKey: .login)
        try container.encode(dob, forKey: .dob)
        try container.encode(registered, forKey: .registered)
        try container.encode(phone, forKey: .phone)
        try container.encode(cell, forKey: .cell)
        try container.encode(id, forKey: .id)
        try container.encode(picture, forKey: .picture)
        try container.encode(nat, forKey: .nat)
    }
}
