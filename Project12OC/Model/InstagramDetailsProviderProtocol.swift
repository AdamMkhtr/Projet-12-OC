//
//  InstagramDetailsProviderProtocol.swift
//  Project12OC
//
//  Created by Adam Mokhtar on 10/02/2022.
//

import Foundation

protocol InstagramDetailsProviderProtocol {
  func fetchDetailsPictures(
    idPicture: String,
    completion: @escaping ((Result<DetailsPictures, Error>) -> Void)
  )
}
