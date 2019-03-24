//
//  RequesterTests.swift
//  MoviesTests
//
//  Created by Arthur Castro on 23/03/19.
//  Copyright © 2019 Arthur Castro. All rights reserved.
//

import XCTest
@testable import Movies

class RequesterTests: XCTestCase {
    
    func testStringRequest(){
        let requester = Requester()
        requester.delegate = RequesterMock()
        
        let expectation = XCTestExpectation(description: "Wait response")
        requester.get(URL(string: "https://google.com.br")!, parameters: [:]) { (result) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, fakeResponse)
                expectation.fulfill()
            case .error(_):
                XCTFail("The requester has changed the response")
            }
        }
        self.wait(for: [expectation], timeout: 1)
    }

}

fileprivate let fakeResponse = """
{
"page": 1,
"total_results": 19788,
"total_pages": 990,
"results": [
{
"vote_count": 1212,
"id": 428078,
"video": false,
"vote_average": 5.9,
"title": "Mortal Engines",
"popularity": 90.397,
"poster_path": "/uXJVpPXxZO4L8Rz3IG1Y8XvZJcg.jpg",
"original_language": "en",
"original_title": "Mortal Engines",
"genre_ids": [
878,
28,
12,
14,
53
],
"backdrop_path": "/jnOuttTfG9KKpmOZtprC4pA1AlZ.jpg",
"adult": false,
"overview": "Many thousands of years in the future, Earth’s cities roam the globe on huge wheels, devouring each other in a struggle for ever diminishing resources. On one of these massive traction cities, the old London, Tom Natsworthy has an unexpected encounter with a mysterious young woman from the wastelands who will change the course of his life forever.",
"release_date": "2018-11-27"
}
]
}
"""

class RequesterMock: RequesterDelegate  {
    func request(url: URL, method: RequestType, parameters: [String : String], completion: @escaping (Result<String>) -> Void) {
        completion(Result.success(fakeResponse))
    }
}
