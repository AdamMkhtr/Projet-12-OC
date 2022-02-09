//
//  YoutubeHeaderView.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 04/11/2021.
//

import UIKit

class YoutubeHeaderView: UITableViewHeaderFooterView {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  weak var delegate: YoutubeHeaderDelegate?

  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------

  @IBOutlet weak var shortsLabel: UILabel!
  @IBOutlet weak var principaleLabel: UILabel!
  @IBOutlet weak var VODLabel: UILabel!
  @IBOutlet weak var principaleView: UIView!
  @IBOutlet weak var VODView: UIView!
  @IBOutlet weak var shortsView: UIView!

  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    setupTapGestureRecognizer()
    recolorAllView()
    principaleLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }

  /// Setup the gesture recognizer for the header youtube collection view
  func setupTapGestureRecognizer() {
    let tapGesturePrincipale = UITapGestureRecognizer()
    self.principaleView.addGestureRecognizer(tapGesturePrincipale)
    tapGesturePrincipale.addTarget(self, action: #selector(tapPrincipale))

    let tapGestureVOD = UITapGestureRecognizer()
    self.VODView.addGestureRecognizer(tapGestureVOD)
    tapGestureVOD.addTarget(self, action: #selector(tapVOD))

    let tapGestureShort = UITapGestureRecognizer()
    self.shortsView.addGestureRecognizer(tapGestureShort)
    tapGestureShort.addTarget(self, action: #selector(tapShort))
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /// Recolor all views if is not selected
  private func recolorAllView() {
    let selectedLabels: [UILabel] =
    [shortsLabel, principaleLabel, VODLabel]
    for selectedLabel in selectedLabels {
      selectedLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
  }

  /// Change the color of the cell and call the delegate
  @objc func tapPrincipale() {
    recolorAllView()
    principaleLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    delegate?.didLauchRequestPrincipale()
  }

  /// Change the color of the cell and call the delegate
  @objc func tapVOD() {
    recolorAllView()
    VODLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    delegate?.didLauchRequestVOD()
  }

  ///Cchange the color of the cell and call the delegate
  @objc func tapShort() {
    recolorAllView()
    shortsLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    delegate?.didLauchRequestShort()
  }
}

//----------------------------------------------------------------------------
// MARK: - Protocol
//----------------------------------------------------------------------------

protocol YoutubeHeaderDelegate: AnyObject {
  func didLauchRequestVOD()
  func didLauchRequestShort()
  func didLauchRequestPrincipale()
}

