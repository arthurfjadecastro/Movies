//
//  K.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation


struct K {
    private init (){
        
    }
    
    struct API {
        static let theMovieDataBase: URL = {
            guard let url = URL(string: "http://api.themoviedb.org/3/movie/popular") else {
                fatalError("Unable to create API URL from path")
            }
            return url
        }()
        static let theMovieDataBaseImage: URL = {
            guard let url = URL(string: "http://image.tmdb.org/t/p/w342") else {
                fatalError("Unable to create image URL from path")
            }
            return url
        }()
        static let theMovieDataBaseGenres: URL = {
            guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list") else {
                fatalError("Unable to create genres URL from path")
            }
            return url
        }()
      
    }
    
    struct Keys {
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
        
        static var theMovieDatabase: String {
            guard let key =  Keys.config["THE_MOVIE_DATABASE_KEY"] else {
                fatalError("You didn't add the key used to retrieve movies from 'The Movie Database' API")
            }
            return key
        }
    }
    
    
    
}
