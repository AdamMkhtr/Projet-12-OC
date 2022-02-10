//
//  InstagramDetailsProvider.swift
//  Project12OCTests
//
//  Created by Adam Mokhtar on 10/02/2022.
//

import XCTest
@testable import Project12OC

class InstagramDetailsProviderMock: InstagramDetailsProviderProtocol {
  func fetchDetailsPictures(idPicture: String, completion: @escaping ((Result<DetailsPictures, Error>) -> Void)) {
    let result = DetailsPictures(id: "", mediaURL: "", caption: "", permalink: "")
    return completion(.success(result))
  }

}

class YoutubeDetailsProviderTest: XCTestCase {

  func fetchDetailsPictures() throws {
    let mock = InstagramDetailsProviderMock()

    let expectation = self.expectation(description: "Fetching")

    mock.fetchDetailsPictures(idPicture: "") { result in
      let searchResult = try? result.get()

      expectation.fulfill()

      XCTAssertNotNil(searchResult)
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
