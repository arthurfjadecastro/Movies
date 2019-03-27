//
//  Result.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation

///
enum Result<T> {
    case error(Error)
    case success(T)
}
