//
//  RequesterDelegate.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import Alamofire


///Enumerator available request types
enum RequestType {
    case get
}

///Protocol request task schema
protocol RequesterDelegate {
    func request(url:URL, method: RequestType, parameters: [String:String], completion: @escaping (Result<Data>) -> Void)
}

/**
    Class Library responsible for configuration and activities at the network layer
    requisicao da web
*/
class AlamofireRequester: RequesterDelegate {
    /**
        Method responsible for configuration and activities at the network layer
     
        - Parameter url: Resource address for access
        - Parameter parameters: Dictionary String to String
        - Parameter completion: A block to execute results Data
    */
    func request(url:URL, method: RequestType, parameters: [String:String], completion: @escaping (Result<Data>) -> Void) {
        var _httpMethod: HTTPMethod
        switch method {
        case .get:
            _httpMethod = .get
        }
        Alamofire.request(url.absoluteString, method: _httpMethod, parameters: parameters).responseData { response in
            if let _error =  response.error {
                completion(Result.error(_error))
                return
            }
            //Transform dynamic error in a static error.
            guard let _body = response.result.value else {
                completion(Result.error(RequesterError.noValue("There's no result from requisition. This should be impossible. Review your code")))
                    return
            }
            completion(Result.success(_body))
        }
    }
}
