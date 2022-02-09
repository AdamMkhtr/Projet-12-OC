//
//  MyCollectionViewLayout.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 31/12/2021.
//

import Foundation
import UIKit

class MyCollectionViewFlowLayout :UICollectionViewFlowLayout {

  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

    guard let collectionView = collectionView else {
      let latestOffset = super.targetContentOffset(
        forProposedContentOffset: proposedContentOffset,
        withScrollingVelocity: velocity
      )
      return latestOffset
    }

    // Page width used for estimating and calculating paging.
    let pageWidth = (itemSize.width / 3) //(itemSize.width / 3)// - 8 //+ self.minimumInteritemSpacing

    // Make an estimation of the current page position.
    let approximatePage = collectionView.contentOffset.x/pageWidth

    // Determine the current page based on velocity.
    let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0.0 ? floor(approximatePage) : ceil(approximatePage))

    // Create custom flickVelocity.
    let flickVelocity = velocity.x * 0.3

    // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
    let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

    // Calculate newHorizontalOffset.
    let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left

    print(newHorizontalOffset)
    print( newHorizontalOffset.truncatingRemainder(dividingBy: itemSize.width) )


    return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
  }

}

