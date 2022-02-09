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
  @IBOutlet weak var youtubeView: UIView!
  
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
    setupYoutube()
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
  
  /// Setup youtube button.
  func setupYoutube() {
    youtubeView.clipsToBounds = true
    youtubeView.layer.cornerRadius = 8
    youtubeView.layer.borderWidth = 0.5
  }
  
  /// Setup gesture recognizer for the views buttons
  func setupTapGestureRecognizer() {
    let tapGestureDeezer = UITapGestureRecognizer()
    self.deezerView.addGestureRecognizer(tapGestureDeezer)
    tapGestureDeezer.addTarget(self, action: #selector(tapDeezer))
    
    let tapGestureSpotify = UITapGestureRecognizer()
    self.spotifyView.addGestureRecognizer(tapGestureSpotify)
    tapGestureSpotify.addTarget(self, action: #selector(tapSpotify))
    
    let tapGestureYoutube = UITapGestureRecognizer()
    self.youtubeView.addGestureRecognizer(tapGestureYoutube)
    tapGestureYoutube.addTarget(self, action: #selector(tapYoutube))
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  ///  Check if the string is correct URL and open the website or the app
  @objc func tapDeezer() {
    let urlDeezer = "https://deezer.page.link/rd6HCi6Xx6rTyWZJ8"
    guard let url = URL(string: urlDeezer) else {
      print("error URL")
      return
    }
    UIApplication.shared.open(url)
  }
  
  ///  Check if the string is correct URL and open the website or the app
  @objc func tapSpotify() {
    let urlSpotify = "https://open.spotify.com/playlist/7n0UKQ9To9gdNxGtV770rP?si=4c5321d427c2432d"
    guard let url = URL(string: urlSpotify) else {
      print("error URL")
      return
    }
    UIApplication.shared.open(url)
  }
  
  ///  Check if the string is correct URL and open the website or the app
  @objc func tapYoutube() {
    let urlYoutube = "https://youtube.com/playlist?list=PLjR2_SGRoaP6LxWsYE3D6g6W529LLNsR5"
    guard let url = URL(string: urlYoutube) else {
      print("error URL")
      return
    }
    UIApplication.shared.open(url)
  }
}
