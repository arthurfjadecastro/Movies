//
//  Requester.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import Alamofire




enum RequesterError: Error {
    case noValue(String)
    case conversionFailed(String)
}


class Requester {
    
    var delegate: RequesterDelegate = AlamofireRequester()
    
    func get(_ url: URL, parameters: [String:String], completion: @escaping (Result<String>) -> Void) {
        self.delegate.request(url: url, method: .get, parameters: parameters, completion: completion)
    }
    
    
    func get<T:Decodable>(_ url: URL, parameters: [String:String], completion: @escaping (Result<T>) -> Void ) {
        self.get(url, parameters: parameters) { (result) in
            switch result {
            case .error(let error):
                completion(Result.error(error))
            case .success(let response):
                let decoder = JSONDecoder()
                guard let data = response.data(using: .utf8) else {
                    completion(Result.error(RequesterError.conversionFailed("Unable to convert string to data")))
                    return
                }
                do {
                    let decodable = try decoder.decode(T.self, from: data)
                    completion(Result.success(decodable))
                }catch{
                    completion(Result.error(error))
                }
            }
        }
    }
    
    
    
    
    
}
