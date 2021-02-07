//
//  ContactManager.swift
//  LydiaTest
//
//  Created by Yannis VERBECQUE on 03/02/2021.
//

import Foundation

// This class will perform all fetching data
class ContactManager: NSObject {
    private let contactURLString: String = "https://randomuser.me/api/1.3/?results=10"
    var resquests: [ContactRequest] = [ContactRequest]()
    var count: Int {
        return self.resquests.compactMap { $0.results.count }.reduce(0, +)
    }
    
    // Download post and decode them from JSON to instantiate Post object
    func downloadContacts(completion: @escaping (_ isCompleted: Bool) -> Void) {
        do {
            var seedURLString: String = String()
            if let firstRequest = self.resquests.first {
                seedURLString = "&seed=\(firstRequest.info.seed)"
            }
            var pageURLString: String = String()
            if let lastRequest = self.resquests.last {
                pageURLString = "&page=\(lastRequest.info.page + 1)"
            }
            
            let URLToRequest: String = contactURLString.appending(seedURLString).appending(pageURLString)
            
            try DownloadManager.downloadWithURL(URLToRequest, completion: { [weak self] (data, response, error) in
                guard error == nil else {
                    completion(false)
                   return
                }
                
                guard let downloadedData = data else {
                    completion(false)
                    return
                }
                
                do {
                    // throws: `DecodingError.dataCorrupted` if cannot decode JSON
                    let request: ContactRequest = try JSONDecoder().decode(ContactRequest.self, from: downloadedData)
                    self?.resquests.append(request)
                    completion(true)
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                    completion(false)
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                    completion(false)
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                    completion(false)
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                    completion(false)
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
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
    
    // return the contact at indexPath.row from the requests made
    func getContactAtIndexPath(_ indexPath: IndexPath) -> Contact? {
        if indexPath.row >= self.count || indexPath.row < 0 {
            return nil
        }
        return self.resquests.compactMap { $0.results }.flatMap { $0 }[indexPath.row]
    }
}
