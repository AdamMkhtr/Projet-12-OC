//
//  InstagramDetailsProvider.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 04/10/2021.
//

import Foundation
import Alamofire

class InstagramDetailsProvider: InstagramDetailsProviderProtocol {
  
  enum InstagramDetailsProviderError: LocalizedError {
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
  
  private var url = "https://graph.instagram.com/"
  
  private let apiKey: String
  
  init(apiKey: String = APIKeys.instagramAPIKey) {
    self.apiKey = apiKey
  }
  
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  /// Call the API edaman for collect data
  /// - Parameters:
  ///   - idPicture: id of picture for which we want details
  ///   - completion: completion return details of picture
  func fetchDetailsPictures(
    idPicture : String,
    completion: @escaping ((Result<DetailsPictures, Error>) -> Void)
  ) {
    let queryParameters: [String: Any] = [
      "fields": "id,media_url,caption,permalink",
      "access_token": apiKey,
    ]
    let request = AF.request(url + idPicture, parameters: queryParameters)
    
    request.responseJSON { (response) in
      guard let data = response.data else {
        completion(.failure(InstagramDetailsProviderError.errorResponse))
        return
      }
      
      do {
        let instagramJSON = try JSONDecoder().decode(DetailsPictures.self, from: data)
        completion(.success(instagramJSON))
      } catch {
        print(error.localizedDescription)
        completion(.failure(error))
      }
    }
  }
}
