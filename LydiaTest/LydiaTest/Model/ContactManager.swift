//
//  ContactManager.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 03/02/2021.
//

import Foundation

// This class will perform all fetching data
class ContactManager: NSObject {
    private let contactURLString: String = "httsps://randomuser.me/api/?results=10"
    var resquests: [ContactRequest] = [ContactRequest]()
    
    // Download post and decode them from JSON to instantiate Post object
    func downloadContacts(completion: @escaping (_ isCompleted: Bool) -> Void) {
        do {
            try DownloadManager.downloadWithURL(contactURLString, completion: { [weak self] (data, response, error) in
                if let downloadedData = data {
                    do {
                        // throws: `DecodingError.dataCorrupted` if cannot decode JSON
                        let request: ContactRequest = try JSONDecoder().decode(ContactRequest.self, from: downloadedData)
                        self?.resquests = [request]
                        completion(true)
                    } catch {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            })
        } catch URLError.badURL {
            print("ContactManager badURL code \(URLError.badURL)")
            completion(false)
        } catch {
            print("Unknown Error \(error) \(error.localizedDescription)")
            completion(false)
        }
    }
}
