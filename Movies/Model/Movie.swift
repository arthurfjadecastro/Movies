//
//  Movie.swift
//
//
//  Created by Arthur Castro on 22/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit

/**
 # Movie
 
    film structure created to match the object proposed by the project
 
    - Important: ImagesCache was created to increase the performance of the application, since reading memory cache data is extremely faster than a disk or a new request. Keep the access data while improving overall application performance. Not using imagesCache can end up occupying memory space.
    - The title of the movie
    - The image of the movie being a url
    - Movie genres can be more than one category
    - Synopsys is the movie description
*/
struct Movie {
    
    //MARK: - Properties
    
    ///Property responsible for storing images of movies
    private static var imagesCache = [String:UIImage]()
    ///Property related to the movie name
    let title: String
    ///Property related to the image movie
    let image: URL
    ///Property contains one or more genres of the movie
    let genres: [String]
    ///Property equivalent to the movie description
    let synopsys: String
    
    //MARK: - Initializer
    
    init(title: String, image: URL, genres: [String], synopsys: String) {
        self.title = title
        self.image = image
        self.genres = genres
        self.synopsys = synopsys
    }
    
    //MARK: - Helper Methods
    
    ///Remove memory space - images
    static func clearCachedImages(){
        self.imagesCache.removeAll()
    }
    
    /**
        Method responsible for acquiring image data, converting it to UIImage and save in memory cache
     
        - Parameter completion: A block to execute results Data/Image
    */
    
    func image(completion: @escaping (Result<UIImage>) -> Void) {
        ///Responsible for images stored
        if let _cachedImage = Movie.imagesCache[self.image.absoluteString]  {
            completion(Result.success(_cachedImage))
            return
        }
        ///Instance Requester
        let _requester = Requester()
        _requester.get(image, parameters: [:]) { (result:Result<Data>) in
            switch result {
            case .error(let _error):
                completion(Result.error(_error))
            case .success(let _data):
                guard let _image = UIImage(data: _data) else {
                    completion(Result.error(RequesterError.conversionFailed("The requested image isn't convertible to UIImage")))
                    return
                }
                Movie.imagesCache[self.image.absoluteString] = _image
                completion(Result.success(_image))
            }
        }
    }
}
