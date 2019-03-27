//
//  MoviesFetcher.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation

///Protocol that define MoviesFetcher
protocol MoviesFetcher {
    func fetch(completion: @escaping (Result<[Movie]>) -> Void)
}


///Class responsible for ensuring that the creation of the update object of the films is not exposed
class MoviesFetcherFactory {
    ///Convenient name factory
    static var `default`: MoviesFetcher { return TheMovieDatabaseFetcher.shared }
}
