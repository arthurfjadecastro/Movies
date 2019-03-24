//
//  TheMovieDatabaseFetcher.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation






fileprivate extension Movie {
    init(movie: TheMovieDatabaseFetcher.MovieModel, genres: [Int:String]) {
        let image = K.API.theMovieDataBaseImage.appendingPathComponent(movie.image)
        let _genres = genres.filter { (key, value) -> Bool in return movie.genres.contains(key) }.values
        self.init(title: movie.title, image: image, genres: Array(_genres), synopsys: movie.synopsys)
    }
}


class TheMovieDatabaseFetcher: MoviesFetcher {
    private var genresCache = [Int:String]()
    
    static let shared = TheMovieDatabaseFetcher()
    
    private init() {}
    
    func fetch(completion: @escaping (Result<[Movie]>) -> Void) {
        let requester = Requester()
        requester.get(K.API.theMovieDataBase, parameters: ["api_key":K.Keys.theMovieDatabase]) { (result:Result<MoviesModel>) in
            
            switch result {
            case .error(let error):
                completion(Result.error(error))
            case .success(let moviesModel):
                
                self.genres(completion: { (result) in
                    switch result {
                    case .error(let error):
                        completion(Result.error(error))
                    case .success(let genres):
                        let movies = moviesModel.results.map({Movie(movie: $0, genres: genres)})
                        completion(Result.success(movies))
                        
                    }
                })
            }
        }
    }
    
    
    
    private func genres(completion: @escaping (Result<[Int:String]>) -> Void ) {
        if(!self.genresCache.isEmpty) {
            completion(Result.success(self.genresCache))
            return
        }
        let requester = Requester()
        requester.get(K.API.theMovieDataBaseGenres, parameters:["api_key":K.Keys.theMovieDatabase,"language":"en-US"]) { (result:Result<GenresModel>) in
            switch result {
            case .error(let error):
                completion(Result.error(error))
            case .success(let genresModel):
                self.genresCache = genresModel.asDictionary()
                completion(Result.success(self.genresCache))
            }

        }
        
    }
    
    
    
    
    struct MovieModel: Decodable {
        
        let title: String
        let image: String
        let genres: [Int]
        let synopsys: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try container.decode(String.self, forKey: .title)
            self.image = try container.decode(String.self, forKey: .image)
            self.genres = try container.decode([Int].self, forKey: .genres)
            self.synopsys = try container.decode(String.self, forKey: .synopsys)
        }
        
        
        init(title: String, image: String, genres: [Int], synopsys: String) {
            self.title = title
            self.image = image
            self.genres = genres
            self.synopsys = synopsys
        }
        
        enum CodingKeys: String, CodingKey {
            case title
            case image = "poster_path"
            case genres = "genre_ids"
            case synopsys = "overview"
        }
    }
    
    
    
    struct MoviesModel: Decodable {
        
        let results: [MovieModel]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.results = try container.decode([MovieModel].self, forKey: .results)
            
        }
        
        init(results: [MovieModel]) {
            self.results = results
        }
        
        enum CodingKeys: CodingKey {
            case results
            
        }
    }
    
    
    struct GenreModel: Decodable {
        
        let id: Int
        let name: String
        
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            
        }
        
        enum CodingKeys: CodingKey {
            case name
            case id
            
            
        }
    }
    
    struct GenresModel: Decodable {
        
        let genres: [GenreModel]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.genres = try container.decode([GenreModel].self, forKey: .genres)
            
        }
        
        enum CodingKeys: CodingKey {
            case genres
            
        }
        
        
        func asDictionary() -> [Int:String] {
            var dictionary = [Int:String]()
            for genre in self.genres {
                dictionary[genre.id] = genre.name
            }
            return dictionary
        }
    }
    
    
}

extension TheMovieDatabaseFetcher.MovieModel: Equatable {
    static func ==(lhs:TheMovieDatabaseFetcher.MovieModel, rhs:TheMovieDatabaseFetcher.MovieModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.genres == rhs.genres &&
            lhs.synopsys == rhs.synopsys
    }
}

extension TheMovieDatabaseFetcher.MoviesModel: Equatable {
    static func ==(lhs:TheMovieDatabaseFetcher.MoviesModel, rhs:TheMovieDatabaseFetcher.MoviesModel) -> Bool {
        return lhs.results == rhs.results
    }
}




