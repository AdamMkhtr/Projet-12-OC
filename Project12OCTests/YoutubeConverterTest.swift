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
    let page = PageInfo(totalResults: 1, resultsPerPage: 1)

    let kind = ItemKind.youtubeSearchResult
    let id = ID(kind: .youtubeVideo, videoID: "")
    let channelID = ChannelID.UCsJ8cjkESfbZM8pAI0GBoNw
    let def = Default(url: "", width: 1, height: 1)
    let thum = Thumbnails(thumbnailsDefault: def, medium: def, high: def)
    let channelTitle = ChannelTitle.Sididi
    let liveBroadcastContent = LiveBroadcastContent.none
    let snippet = Snippet(channelID: channelID, title: "", snippetDescription: "", thumbnails: thum, channelTitle: channelTitle, liveBroadcastContent: liveBroadcastContent)
    let item = Item(kind: kind, etag: "test", id: id, snippet: snippet)





    let result = YoutubeCodable(kind: "",
                                etag: "",
                                nextPageToken: "",
                                regionCode: "",
                                pageInfo: page,
                                items: [item])

    return completion(.success(result))
  }
}


class YoutubeConverterTest: XCTestCase {

  var youtubeResults: [Item]?
  var expectation: XCTestExpectation?

  func test_convert() {
    let converter = YoutubeConverter(youtubeProvider: YoutubeProviderMockTestConvert())

    expectation = expectation(description: "Convert")

    converter.convert(pageToken: "") { [self] result in
      switch result {

      case .success(_):
        try? youtubeResults = result.get()

      case .failure(_): break
      }

      expectation?.fulfill()
    }
    wait(for: [expectation!], timeout: 0.1)
    XCTAssertNotNil(youtubeResults)
    XCTAssertEqual("test", youtubeResults?.first?.etag)
  }

}
