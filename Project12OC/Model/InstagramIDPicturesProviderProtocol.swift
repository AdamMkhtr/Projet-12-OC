//
//  InstagramIDPicturesProviderProtocol.swift
//  Project12OC
//
//  Created by Adam Mokhtar on 10/02/2022.
//

import Foundation

protocol InstagramIDPicturesProviderProtocol {
  func fetchIDPictures(
    completion: @escaping ((Result<InstagramIDPictures, Error>) -> Void)
  )
}
