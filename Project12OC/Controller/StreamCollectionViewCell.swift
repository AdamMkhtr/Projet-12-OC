//
//  StreamCollectionViewCell.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 29/11/2021.
//

import UIKit

class StreamCollectionViewCell: UICollectionViewCell {

  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var hourLabel: UILabel!

  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
        super.awakeFromNib()
    }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /// Color in blue the day of today
  var isCurrentDay: Bool = false {
    didSet {
      titleLabel.textColor = isCurrentDay ? #colorLiteral(red: 0.3423830271, green: 0.9933084846, blue: 0.9951588511, alpha: 1) : .gray
      hourLabel.textColor = isCurrentDay ? #colorLiteral(red: 0.3423830271, green: 0.9933084846, blue: 0.9951588511, alpha: 1) : .gray
    }
  }
  
}
