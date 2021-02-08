//
//  Contactable.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 07/02/2021.
//

import Foundation

protocol Contactable {
    var contact: Contact? { get set }
    func setContact(_ contact: Contact) -> Void
}
