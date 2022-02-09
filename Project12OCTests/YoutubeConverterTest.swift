//
//  YoutubeConverterTest.swift
//  Project12OCTests
//
//  Created by Adam Mokhtar on 09/02/2022.
//

import XCTest
@testable import Project12OC

class YoutubeProviderMockTestConvert: YoutubeProviderProtocol {


  func fetchYoutubeVideos(pageToken: String, completion: @escaping ((Result<YoutubeCodable, Error>) -> Void)) {
    let data = YoutubeCodable(kind: "", etag: "", nextPageToken: "", regionCode: "", pageInfo: nil, items: nil)

    let result =
  }


//  func fetchRecipes(
//    querry: String,
//    completion: @escaping ((Result<SearchResult, Error>) -> Void)
//  ) {
//    let recipe = Recipe(label: "test",
//                        image: "",
//                        url: "",
//                        shareAs: "",
//                        dietLabels: [""],
//                        healthLabels: [""],
//                        cautions: [""],
//                        ingredientLines: [""])
//
//    let hit = Hit(recipe: recipe)
//
//    let result = SearchResult(q: "",
//                              from: 0,
//                              to: 1,
//                              more: true,
//                              count: 1,
//                              hits: [hit])
//
//    return completion(.success(result))
//  }
}

//class YoutubeConverterTest: XCTestCase {
//
//  var youtubeResult: [YoutubeCodable]?
//  var expectation: XCTestExpectation?
//
//  func test_convert() {
//    let converter = YoutubeConverter(youtubeProvider: YoutubeProviderMockTestConvert())
//
//    expectation = expectation(description: "Convert")
//
//    converter.convert(query: "test") { [self] result in
//      switch result {
//
//      case .success(_):
//        try? recipeResults = result.get()
//
//      case .failure(_): break
//      }
//
//      expectation?.fulfill()
//    }
//    wait(for: [expectation!], timeout: 0.1)
//    XCTAssertNotNil(youtubeResult)
//    XCTAssertEqual("test", youtubeResult?.first?.label)
//  }
//
//}
