//
//  InstagramDetailsConverterTest.swift
//  Project12OCTests
//
//  Created by Adam Mokhtar on 10/02/2022.
//

import XCTest
@testable import Project12OC

class InstagramDetailsProviderMockTestConvert: InstagramDetailsProviderProtocol {


  func fetchDetailsPictures(idPicture: String, completion: @escaping ((Result<DetailsPictures, Error>) -> Void)) {
    let result = DetailsPictures(id: "", mediaURL: "test", caption: "", permalink: "")
    return completion(.success(result))
  }

}


class InstagramDetailsConverterTest: XCTestCase {

  var instagramDetailsResult: DetailsPictures?
  var expectation: XCTestExpectation?

  func test_convert() {
    let converter = InstagramDetailsConverter(instagramProvider: InstagramDetailsProviderMockTestConvert())

    expectation = expectation(description: "Convert")

    converter.convert(idPicture: "") { [self] result in
      switch result {

      case .success(let results):
        XCTAssertEqual("test", results.mediaURL)

      case .failure(_): break
      }

      expectation?.fulfill()
    }
    wait(for: [expectation!], timeout: 0.1)
  }

}
