//
//  YoutubeCodable.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 30/10/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let youtubeCodable = try? newJSONDecoder().decode(YoutubeCodable.self, from: jsonData)

import Foundation

// MARK: - YoutubeCodable
struct YoutubeCodable: Codable {
  let kind, etag, nextPageToken, regionCode: String
  let pageInfo: PageInfo
  let items: [Item]
}

// MARK: - Item
struct Item: Codable {
  let kind: ItemKind
  let etag: String
  let id: ID
  let snippet: Snippet
}

// MARK: - ID
struct ID: Codable {
  let kind: IDKind
  let videoID: String
  
  enum CodingKeys: String, CodingKey {
    case kind
    case videoID = "videoId"
  }
}

enum IDKind: String, Codable {
  case youtubeVideo = "youtube#video"
}

enum ItemKind: String, Codable {
  case youtubeSearchResult = "youtube#searchResult"
}

// MARK: - Snippet
struct Snippet: Codable {
  let channelID: ChannelID
  let title, snippetDescription: String
  let thumbnails: Thumbnails
  let channelTitle: ChannelTitle
  let liveBroadcastContent: LiveBroadcastContent

  enum CodingKeys: String, CodingKey {
    case channelID = "channelId"
    case title
    case snippetDescription = "description"
    case thumbnails, channelTitle, liveBroadcastContent//, publishTime
  }
}

enum ChannelID: String, Codable {
  case UCsJ8cjkESfbZM8pAI0GBoNw = "UCsJ8cjkESfbZM8pAI0GBoNw"
}

enum ChannelTitle: String, Codable {
  case Sididi = "Sididi"

}

enum LiveBroadcastContent: String, Codable {
  case none = "none"
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
  let thumbnailsDefault, medium, high: Default
  
  enum CodingKeys: String, CodingKey {
    case thumbnailsDefault = "default"
    case medium, high
  }
}

// MARK: - Default
struct Default: Codable {
  let url: String
  let width, height: Int
}

// MARK: - PageInfo
struct PageInfo: Codable {
  let totalResults, resultsPerPage: Int
}
