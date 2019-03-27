//
//  Result.swift
//  Movies
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import Foundation

///Possible definitions with only cases
enum Result<T> {
    case error(Error)
    case success(T)
}
