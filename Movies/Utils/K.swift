//
//  K.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation
import UIKit

/**
    Structure contains constants of project
*/
struct K {
    
    private init (){}
    
    /**
        API Movie - http://api.themoviedb.org
    */
    struct API {
        /**
            Property computed with a string url that is required for data consumption
            - Return: Url DataBase
         */
        static let theMovieDataBase: URL = {
            guard let url = URL(string: "http://api.themoviedb.org/3/movie/popular") else {
                fatalError("Unable to create API URL from path")
            }
            return url
        }()
        /**
         Property computed with a string url that is required for image consumption
         - Return: Url Image
         */
        static let theMovieDataBaseImage: URL = {
            guard let url = URL(string: "http://image.tmdb.org/t/p/w500") else {
                fatalError("Unable to create image URL from path")
            }
            return url
        }()
        /**
         Property computed with a string url that is required for genres consumption
         - Return: Url Genres
         */
        static let theMovieDataBaseGenres: URL = {
            guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list") else {
                fatalError("Unable to create genres URL from path")
            }
            return url
        }()
      
    }
    /**
        Structure that contains the organization of paths and keys to be used in the movie api
    */
    struct Keys {
        /**
         - Return: name key 
         */
        static var theMovieDatabase: String {
            guard let key =  Keys.config["THE_MOVIE_DATABASE_KEY"] else {
                fatalError("You didn't add the key used to retrieve movies from 'The Movie Database' API")
            }
            return key
        }
        /**
            Property computed obtaining key value
            - Note: There is configuration to search the path of file where the key to be used is located
            - Return: Key in dictionary format String
         */
        private static let config: [String:String] = {
            guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
                fatalError("Keys.plist not found")
            }
            let url = URL(fileURLWithPath: path)
            guard let keys = NSDictionary(contentsOf: url) as? [String:String] else {
                fatalError("Each key and value in Keys.plist file must be of type String")
            }
            return keys
        }()
    }
    /**
        Constant values for layout Cell in TableView
     */
    struct LayoutCell {
        static let widthInRelationToTableView: CGFloat = 1
        static let heightInRelationToWidth: CGFloat = ( 513 + 34 ) / 342
    }

}
