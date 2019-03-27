//
//  Requester.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import Alamofire

///Enumeration containing requisition error
enum RequesterError: Error {
    case noValue(String)
    case conversionFailed(String)
}

///Class responsible for managing requests
class Requester {
    
    
    ///This delegate created because unit test
    var delegate: RequesterDelegate = AlamofireRequester()
    
    /**
     Method responsible for translating the data
     
     - Parameter url: Resource address for access
     - Parameter parameters: Dictionary String to String
     - Parameter completion: A block to execute results Decodable
     
     - Note: The encoding use utf8, conversion to string
     */
    func get<T:Decodable>(_ url: URL, parameters: [String:String], completion: @escaping (Result<T>) -> Void ) {
        self.get(url, parameters: parameters) { (result:Result<String>) in
            switch result {
            case .error(let _error):
                completion(Result.error(_error))
            case .success(let _response):
                let decoder = JSONDecoder()
                guard let _data = _response.data(using: .utf8) else {
                    completion(Result.error(RequesterError.conversionFailed("Unable to convert string to data")))
                    return
                }
                do {
                    let _decodable = try decoder.decode(T.self, from: _data)
                    completion(Result.success(_decodable))
                }catch{
                    completion(Result.error(error))
                }
            }
        }
    }
    
    /**
        Method responsible for obtaining the data string
     
        - Parameter url: Resource address for access
        - Parameter parameters: Dictionary String to String
        - Parameter completion: A block to execute results Data/String
     
        - Note: The encoding use utf8, conversion to string
     */
    func get(_ url: URL, parameters: [String:String], completion: @escaping (Result<String>) -> Void) {
        self.delegate.request(url: url, method: .get, parameters: parameters, completion: { (result) in
            switch result {
            case .error(let _error):
                completion(Result.error(_error))
            case .success(let _data):
                guard let _string = String(data: _data, encoding: .utf8) else {
                    completion(Result.error(RequesterError.conversionFailed("The requested content isn't convertible to String")))
                    return
                }
                completion(Result.success(_string))
            }
        })
    }
    
    /**
     Method responsible for obtaining the data in bytes
     
     - Parameter url: Resource address for access
     - Parameter parameters: Dictionary String to String
     - Parameter completion: A block to execute results Data
     
     - Note: Search for image data to cache memory
     */
    func get(_ url: URL, parameters: [String:String], completion: @escaping (Result<Data>) -> Void) {
        self.delegate.request(url: url, method: .get, parameters: parameters, completion: completion)
    }
    
   
}
