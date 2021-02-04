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
        let postcode: Int
        let coordinates: Coordinate
        let timezone: Timezone
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
        let name: String?
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
