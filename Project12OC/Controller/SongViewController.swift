//
//  SongViewController.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 24/09/2021.
//

import UIKit

class SongViewController: UIViewController {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  @IBOutlet weak var deezerView: UIView!
  @IBOutlet weak var spotifyView: UIView!
  
  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTapGestureRecognizer()
    setupButtonsView()
  }
  
  /// Call the all fuctions for setup buttons
  func setupButtonsView() {
    setupDeezer()
    setupSpotify()
  }
  
  /// Setup deezer button.
  func setupDeezer() {
    deezerView.clipsToBounds = true
    deezerView.layer.cornerRadius = 8
    deezerView.layer.borderWidth = 0.5
  }
  
  /// Setup spotify button.
  func setupSpotify() {
    spotifyView.clipsToBounds = true
    spotifyView.layer.cornerRadius = 8
    spotifyView.layer.borderWidth = 0.5
  }

  
  /// Setup gesture recognizer for the views buttons
  func setupTapGestureRecognizer() {
    let tapGestureDeezer = UITapGestureRecognizer()
    self.deezerView.addGestureRecognizer(tapGestureDeezer)
    tapGestureDeezer.addTarget(self, action: #selector(tapDeezer))
    
    let tapGestureSpotify = UITapGestureRecognizer()
    self.spotifyView.addGestureRecognizer(tapGestureSpotify)
    tapGestureSpotify.addTarget(self, action: #selector(tapSpotify))

  }
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  ///  Check if the string is correct URL and open the website or the app
  @objc func tapDeezer() {
    let urlDeezer = "https://www.deezer.com/fr/playlist/9764256762"
    guard let url = URL(string: urlDeezer) else {
      print("error URL")
      return
    }
    UIApplication.shared.open(url)
  }
  
  ///  Check if the string is correct URL and open the website or the app
  @objc func tapSpotify() {
    let urlSpotify = "https://open.spotify.com/playlist/35nWO8E4zm5Re7aMrmIy7N"
    guard let url = URL(string: urlSpotify) else {
      print("error URL")
      return
    }
    UIApplication.shared.open(url)
  }
}
