//
//  RequesterDelegate.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import Alamofire


enum RequestType {
    case get
}


protocol RequesterDelegate {
    
    func request(url:URL, method: RequestType, parameters: [String:String], completion: @escaping (Result<Data>) -> Void)
    
}

class AlamofireRequester: RequesterDelegate {
    func request(url:URL, method: RequestType, parameters: [String:String], completion: @escaping (Result<Data>) -> Void) {
        var httpMethod: HTTPMethod
        switch method {
        case .get:
            httpMethod = .get
        }
        Alamofire.request(url.absoluteString, method: httpMethod, parameters: parameters).responseData { response in
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
}
