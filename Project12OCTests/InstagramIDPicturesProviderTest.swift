//
//  InstagramIDPicturesProviderTest.swift
//  Project12OCTests
//
//  Created by Adam Mokhtar on 10/02/2022.
//

import XCTest
@testable import Project12OC

class InstagramIDpicturesProviderMock: InstagramIDPicturesProviderProtocol {
  func fetchIDPictures(completion: @escaping ((Result<InstagramIDPictures, Error>) -> Void)) {
    let curs = Cursors(before: "", after: "")
    let paging = Paging(cursors: curs)
    let datum = Datum(id: "")
    let media = Media(data: [datum], paging: paging)

    let result = InstagramIDPictures(media: media, id: "test")

    return completion(.success(result))
  }

}

class YoutubeIDPicturesProviderTest: XCTestCase {

  func fetchIDPictures() throws {
    let mock = InstagramIDpicturesProviderMock()

    let expectation = self.expectation(description: "Fetching")

    mock.fetchIDPictures() { result in
      let searchResult = try? result.get()

      expectation.fulfill()

      XCTAssertNotNil(searchResult)
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
