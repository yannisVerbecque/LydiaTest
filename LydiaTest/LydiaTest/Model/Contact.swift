//
//  Contact.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 02/02/2021.
//

import Foundation

// Mark: Contact
struct Contact: Decodable {
    struct Name: Decodable {
        let title: String
        let first: String
        let last: String
    }
    struct Street: Decodable {
        let number: Int
        let name: String
    }
    struct Coordinate: Decodable {
        let latitude: String
        let longitude: String
    }
    struct Timezone: Decodable {
        let offset: String
        let description: String
    }
    struct Location: Decodable {
        let street: Street
        let city: String
        let state: String
        let country: String
        // The API serves Int and String
        let postcode: String
        let coordinates: Coordinate
        let timezone: Timezone
        
        enum CodingKeys: String, CodingKey {
            case street
            case city
            case state
            case country
            case postcode
            case coordinates
            case timezone
        }
        
        // Had to decode this with the hands
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            street = try values.decode(Street.self, forKey: .street)
            city = try values.decode(String.self, forKey: .city)
            state = try values.decode(String.self, forKey: .state)
            country = try values.decode(String.self, forKey: .country)
            do {
                postcode = try values.decode(String.self, forKey: .postcode)
            } catch DecodingError.typeMismatch {
                let nombre = try values.decode(Int.self, forKey: .postcode)
                postcode = nombre.description
            } catch {
                postcode = "error decoding"
            }
            coordinates = try values.decode(Coordinate.self, forKey: .coordinates)
            timezone = try values.decode(Timezone.self, forKey: .timezone)
        }
    }
    struct Login: Decodable {
        let uuid: String
        let username: String
        let password: String
        let salt: String
        let md5: String
        let sha1: String
        let sha256: String
    }
    struct DateEvent: Decodable {
        let date: String
        let age: Int
    }
    struct Id: Decodable {
        let name: String
        let value: String?
    }
    struct PictureLink: Decodable {
        let large: String
        let medium: String
        let thumbnail: String
    }

    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DateEvent
    let registered: DateEvent
    let phone: String
    let cell: String
    let id: Id
    let picture: PictureLink
    let nat: String
}

// Mark: Info
struct Info: Decodable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

// Mark: Request result object
struct ContactRequest: Decodable {
    let results: [Contact]
    let info: Info
}

// Mark Error Description from API
struct ErrorAPI: Decodable {
    let error: String
}
