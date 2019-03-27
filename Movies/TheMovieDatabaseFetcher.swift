//
//  TheMovieDatabaseFetcher.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation



/**
 
*/
class TheMovieDatabaseFetcher: MoviesFetcher {
    
    //MARK: - Properties
    
    
    private var genresCache = [Int:String]()
    
    //MARK: - Shared Instance
    static let shared = TheMovieDatabaseFetcher()
    
    //MARK: - Initializer
    ///Can't init is singleton
    private init() {}
    
    //MARK: - Helper methods
    
    
    private func genres(completion: @escaping (Result<[Int:String]>) -> Void ) {
        if(!self.genresCache.isEmpty) {
            completion(Result.success(self.genresCache))
            return
        }
        let _requester = Requester()
        _requester.get(K.API.theMovieDataBaseGenres, parameters:["api_key":K.Keys.theMovieDatabase,"language":"en-US"]) { (result:Result<GenresModel>) in
            switch result {
            case .error(let _error):
                completion(Result.error(_error))
            case .success(let _genresModel):
                //Parse
                self.genresCache = _genresModel.asDictionary()
                completion(Result.success(self.genresCache))
            }
        }
        
    }
    
  
    /**
        Method that updates the movies accordingly the imposed rules.
     - Note: The requirement of the site is to provide the API, encapsulating and abstracting its search into the Keys file. Attention to the explicit type of MoviesModel that removes method call ambiguity.
    */
    func fetch(completion: @escaping (Result<[Movie]>) -> Void) {
        ///Responsible for making requests
        let _requester = Requester()
        _requester.get(K.API.theMovieDataBase, parameters: ["api_key":K.Keys.theMovieDatabase]) { (result:Result<MoviesModel>) in
            switch result {
            case .error(let _error):
                completion(Result.error(_error))
            case .success(let _moviesModel):
                self.genres(completion: { (result) in
                    switch result {
                    case .error(let _error):
                        completion(Result.error(_error))
                    case .success(let _genres):
                        //Parse
                        let _movies = _moviesModel.results.map({Movie(movie: $0, genres: _genres)})
                        completion(Result.success(_movies))
                    }
                })
            }
        }
    }
 
    
    /**
        - Model structure that reflects the object of consumption, movie.
     
        - Note: Adopt Decodable simplifying conversion
    */
    struct MovieModel: Decodable {
        
        ///Enumerator for encoding key Movie
        enum CodingKeys: String, CodingKey {
            case title
            case image = "poster_path"
            case genres = "genre_ids"
            case synopsys = "overview"
        }
  
        
        ///Represents title at movie
        let title: String
        ///Represents poster_path at movie
        let image: String
        ///Represents genre_ids at movie
        let genres: [Int]
        ///Represents overview at movie
        let synopsys: String

       
        
        //Decoder initializer needs container
        init(from decoder: Decoder) throws {
            let _container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try _container.decode(String.self, forKey: .title)
            self.image = try _container.decode(String.self, forKey: .image)
            self.genres = try _container.decode([Int].self, forKey: .genres)
            self.synopsys = try _container.decode(String.self, forKey: .synopsys)
        }
        
        init(title: String, image: String, genres: [Int], synopsys: String) {
            self.title = title
            self.image = image
            self.genres = genres
            self.synopsys = synopsys
        }
    }

    /**
        - Model structure that reflects the object of consumption, all movies.
     
        - Note: results represents all movies consumed at API
        - Note: Adopt Decodable simplifying conversion
    */
    struct MoviesModel: Decodable {
        
        ///Enumerator for encoding key all movies
        enum CodingKeys: CodingKey {
            case results
        }
        
   
        
        ///Represents result of all API movies
        let results: [MovieModel]
        
      
        
        //Decoder initializer needs container
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.results = try container.decode([MovieModel].self, forKey: .results)
            
        }
        
        init(results: [MovieModel]) {
            self.results = results
        }
        
    }
    
     /**
        - Model structure that reflects the object of consumption, genre.
     
        - Note: Adopt Decodable simplifying conversion
     */
    struct GenreModel: Decodable {
        ///Enumerator for encoding key genre
        enum CodingKeys: CodingKey {
            case name
            case id
        }
        
      
        
        ///Represents genre id at API movies
        let id: Int
        ///Represents name genre at API movies
        let name: String
        
    
        
        //Decoder initializer needs container
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
        }
    }
    
    /**
     - Model structure that reflects the object of consumption, all genres.
     
     - Note: Adopt Decodable simplifying conversion
     */
    struct GenresModel: Decodable {
        
        ///Enumerator for encoding key genres
        enum CodingKeys: CodingKey {
            case genres
        }
        
        
        ///Represents all genres id of each movie
        let genres: [GenreModel]
        
     
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.genres = try container.decode([GenreModel].self, forKey: .genres)
            
        }
       
       ///Method responsible for converting integer to string
       func asDictionary() -> [Int:String] {
            var dictionary = [Int:String]()
            for genre in self.genres {
                dictionary[genre.id] = genre.name
            }
            return dictionary
        }
    }
}

//MARK: - Extensions

fileprivate extension Movie {
    /**
        Initializer is responsible for performing the data transformation
     
        - Note: The process  through entities analysis, where the image is
                transformed into a complete url and the genres ids are
                transformed into string
    */
    init(movie: TheMovieDatabaseFetcher.MovieModel, genres: [Int:String]) {
        let _image = K.API.theMovieDataBaseImage.appendingPathComponent(movie.image)
        let _genres = genres.filter { (key, value) -> Bool in return movie.genres.contains(key) }.values
        self.init(title: movie.title, image: _image, genres: Array(_genres), synopsys: movie.synopsys)
    }
}

extension TheMovieDatabaseFetcher.MovieModel: Equatable {
    
    ///Verify all attributes Movie, equivalent and conform.
    static func ==(lhs:TheMovieDatabaseFetcher.MovieModel, rhs:TheMovieDatabaseFetcher.MovieModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.genres == rhs.genres &&
            lhs.synopsys == rhs.synopsys
    }
}

extension TheMovieDatabaseFetcher.MoviesModel: Equatable {
    
    ///Verify all movies, equivalent and conform
    static func ==(lhs:TheMovieDatabaseFetcher.MoviesModel, rhs:TheMovieDatabaseFetcher.MoviesModel) -> Bool {
        return lhs.results == rhs.results
    }
}






