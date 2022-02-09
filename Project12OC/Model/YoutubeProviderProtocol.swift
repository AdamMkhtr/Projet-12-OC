//
//  YoutubeProviderProtocol.swift
//  Project12OC
//
//  Created by Adam Mokhtar on 09/02/2022.
//

import Foundation

protocol YoutubeProviderProtocol {
  func fetchYoutubeVideos(
    pageToken: String,
    completion: @escaping ((Result<YoutubeCodable, Error>) -> Void)
  )
}
