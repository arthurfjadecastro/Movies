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



class MoviesFetcherFactory {
    static var `default`: MoviesFetcher { return TheMovieDatabaseFetcher.shared }
}
