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
    
    
    func get(_ url: URL, parameters: [String:String], completion: @escaping (Result<String>) -> Void ) {

        Alamofire.request(url.absoluteString, method: .get, parameters: parameters).responseString { response in
            if let error =  response.error {
                completion(Result.error(error))
                return
            }
            //Transform dynamic error in a static error.
            guard let body = response.result.value else {
                completion(Result.error(RequesterError.noValue("There's no result from requisition. This should be impossible. Review your code")))
                return
            }
            completion(Result.success(body))
        }
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
