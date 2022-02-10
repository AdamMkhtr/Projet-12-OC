//
//  InstagramIDPicturesConverterTest.swift
//  Project12OCTests
//
//  Created by Adam Mokhtar on 10/02/2022.
//

import XCTest
@testable import Project12OC

class InstagramIDPicturesProviderMockTestConvert: InstagramIDPicturesProviderProtocol {
  
  func fetchIDPictures(completion: @escaping ((Result<InstagramIDPictures, Error>) -> Void)) {
    let curs = Cursors(before: "", after: "")
    let paging = Paging(cursors: curs)
    let datum = Datum(id: "test")
    let media = Media(data: [datum], paging: paging)

    let result = InstagramIDPictures(media: media, id: "test")
//    let result = [resultOfCall.id]

    return completion(.success(result))
  }
}


class InstagramIDPicturesConverterTest: XCTestCase {

  ///var instagramIDPicturesResult: [String]?
  var expectation: XCTestExpectation?

  func test_convert() {
    let converter = InstagramIDPicturesConverter(instagramProvider: InstagramIDPicturesProviderMockTestConvert())

    expectation = expectation(description: "Convert")

    converter.convertIDPictures() { [self] result in
      switch result {

      case .success(let ids):
        print(ids)
        XCTAssertEqual("test", ids.first)

      case .failure(_):
        XCTFail()
        break
      }

      expectation?.fulfill()
    }
    wait(for: [expectation!], timeout: 0.1)
  }

}

