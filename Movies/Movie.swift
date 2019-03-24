//
//  MoviesConcern.swift
//  Movies
//
//  Created by Arthur Castro on 22/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit




enum Genre {
    case action
}


struct Movie {
    
    //MARK: - Properties
    private static var imagesCache = [String:UIImage]()
    let title: String
    let image: URL
    let genres: [String]
    let synopsys: String
    
    
    init(title: String, image: URL, genres: [String], synopsys: String) {
        self.title = title
        self.image = image
        self.genres = genres
        self.synopsys = synopsys
    }
    
    static func clearCachedImages(){
        self.imagesCache.removeAll()
    }
    
    func image(completion: @escaping (Result<UIImage>) -> Void) {
        if let cachedImage = Movie.imagesCache[self.image.absoluteString]  {
            completion(Result.success(cachedImage))
            return
        }
        let requester = Requester()
        requester.get(image, parameters: [:]) { (result:Result<Data>) in
            switch result {
            case .error(let error):
                completion(Result.error(error))
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(Result.error(RequesterError.conversionFailed("The requested image isn't convertible to UIImage")))
                    return
                }
                
                Movie.imagesCache[self.image.absoluteString] = image
                completion(Result.success(image))
                
                
            }
        }
        
    }

}
