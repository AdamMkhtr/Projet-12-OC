//
//  YoutubeProvider.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 30/10/2021.
//

import Foundation
import Alamofire

class YoutubeProvider {
  
  //----------------------------------------------------------------------------
  // MARK: - Error Management
  //----------------------------------------------------------------------------
  
  enum YoutubeProviderError: LocalizedError {
    case errorResponse
    
    var errorDescription: String? {
      switch self {
      case .errorResponse: return "error response"
      }
    }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  private var url = "https://www.googleapis.com/youtube/v3/search?"
  
  private let apiKey: String
  
  init(apiKey: String = APIKeys.youtubeAPIKey) {
    self.apiKey = apiKey
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  /// Call the API Youtube for collect data
  /// - Parameters:
  ///   - completion: completion return youtube details data
  func fetchYoutubeVideos(
    pageToken: String,
    completion: @escaping ((Result<YoutubeCodable, Error>) -> Void)
  ) {
    let queryParameters: [String: Any] = [
      "order": "date",
      "part": "snippet",
      "channelId": "UCvuACILbubOXV_OMBWqLM2g",
      "maxResults": "5",
      "pageToken": pageToken,
      "key": apiKey
    ]
    let request = AF.request(url, parameters: queryParameters)
    
    request.responseJSON { (response) in
      guard let data = response.data else {
        completion(.failure(YoutubeProviderError.errorResponse))
        return
      }
      print(response.response?.statusCode)
      print(response.description)
      do {
        let youtubeJSON = try JSONDecoder().decode(YoutubeCodable.self, from: data)
        print(youtubeJSON)
        completion(.success(youtubeJSON))
      } catch {
        print(error)
        print(error.localizedDescription)
        completion(.failure(error))
      }
    }
  }
  
}
