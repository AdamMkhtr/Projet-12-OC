//
//  InstagramCodable.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 03/10/2021.
//

import Foundation

//----------------------------------------------------------------------------
// MARK: - Codable for IDPictures
//----------------------------------------------------------------------------

// MARK: - InstagramIDPictures
struct InstagramIDPictures: Codable {
  let media: Media
  let id: String
}

// MARK: - Media
struct Media: Codable {
  let data: [Datum]
  let paging: Paging 
}

// MARK: - Datum
struct Datum: Codable {
  let id: String
}

// MARK: - Paging
struct Paging: Codable {
  let cursors: Cursors
}

// MARK: - Cursors
struct Cursors: Codable {
  let before, after: String
}

//----------------------------------------------------------------------------
// MARK: - Codable for Details Instagram Pictures
//----------------------------------------------------------------------------

struct DetailsPictures: Codable {
  let id: String
  let mediaURL: String
  let caption: String?
  let permalink: String
  
  
  enum CodingKeys: String, CodingKey {
    case id
    case mediaURL = "media_url"
    case caption, permalink
  }
}

