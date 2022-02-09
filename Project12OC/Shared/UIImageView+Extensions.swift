//
//  Extension.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 03/10/2021.
//

import Foundation
import UIKit

//----------------------------------------------------------------------------
// MARK: - Extension Image view
//----------------------------------------------------------------------------

extension UIImageView {
  
  /// upload image with url
  /// - Parameter link: url for upload
  func load(link: String) {
    guard  let url = URL(string: link) else {
      return
    }
    DispatchQueue.global().async { [weak self] in
      guard let data = try? Data(contentsOf: url) else {
        return
      }
      guard let image = UIImage(data: data) else {
        return
      }
      DispatchQueue.main.async {
        self?.image = image
      }
    }
  }
}
