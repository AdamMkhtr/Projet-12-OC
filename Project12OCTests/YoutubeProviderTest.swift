//
//  YoutubeProviderTest.swift
//  Project12OCTests
//
//  Created by Adam Mokhtar on 09/02/2022.
//

import XCTest
@testable import Project12OC

class YoutubeProviderMock: YoutubeProviderProtocol {

  func fetchYoutubeVideos(
    pageToken: String,
    completion: @escaping ((Result<YoutubeCodable, Error>) -> Void)
  ) {


    let page = PageInfo(totalResults: 1, resultsPerPage: 1)

    let kind = ItemKind.youtubeSearchResult
    let id = ID(kind: .youtubeVideo, videoID: "")
    let channelID = ChannelID.UCsJ8cjkESfbZM8pAI0GBoNw
    let def = Default(url: "", width: 1, height: 1)
    let thum = Thumbnails(thumbnailsDefault: def, medium: def, high: def)
    let channelTitle = ChannelTitle.Sididi
    let liveBroadcastContent = LiveBroadcastContent.none
    let snippet = Snippet(channelID: channelID, title: "", snippetDescription: "", thumbnails: thum, channelTitle: channelTitle, liveBroadcastContent: liveBroadcastContent)
    let item = Item(kind: kind, etag: "", id: id, snippet: snippet)





    let result = YoutubeCodable(kind: "",
                                etag: "",
                                nextPageToken: "",
                                regionCode: "",
                                pageInfo: page,
                                items: [item])


    return completion(.success(result))
  }
}

class YoutubeProviderTest: XCTestCase {

  func testFetchYoutubeVideos() throws {
    let mock = YoutubeProviderMock()

    let expectation = self.expectation(description: "Fetching")

    mock.fetchYoutubeVideos(pageToken: "") { result in
      let searchResult = try? result.get()

      expectation.fulfill()

      XCTAssertNotNil(searchResult)
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
