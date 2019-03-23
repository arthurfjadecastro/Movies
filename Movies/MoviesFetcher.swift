//
//  MoviesFetcher.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation


protocol MoviesFetcher {
    func fetch(completion: @escaping (Result<[Movie]>) -> Void)
}


class MoviesFetcherFactory {
    static var `default`: MoviesFetcher { return TheMovieDatabaseFetcher.shared }
}
