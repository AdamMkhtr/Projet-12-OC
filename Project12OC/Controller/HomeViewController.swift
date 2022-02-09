//
//  HomeViewController.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 14/09/2021.
//

import UIKit

class HomeViewController: UIViewController {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var didTapMenu: (() -> Void)?
  var didTapNotification: (() -> Void)?
  var didTapStream: (() -> Void)?
  var didTapVideo: (() -> Void)?
  var didTapInstagram: (() -> Void)?
  var didTapSong: (() -> Void)?
  
  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------
  
  @IBOutlet weak var streamBarView: UIView!
  @IBOutlet weak var videoBarView: UIView!
  @IBOutlet weak var instagramBarView: UIView!
  @IBOutlet weak var songBarView: UIView!
  
  //----------------------------------------------------------------------------
  // MARK: - Inits
  //----------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTapGestureRecognizer()
    setupButtons()
    tapStream()
  }
  
  /// Setup the tap gesture recognizer for the menu tab button.
  func setupTapGestureRecognizer() {
    let tapGestureStream = UITapGestureRecognizer()
    self.streamBarView.addGestureRecognizer(tapGestureStream)
    tapGestureStream.addTarget(self, action: #selector(tapStream))
    
    let tapGestureVideo = UITapGestureRecognizer()
    self.videoBarView.addGestureRecognizer(tapGestureVideo)
    tapGestureVideo.addTarget(self, action: #selector(tapVideo))
    
    let tapGestureInstagram = UITapGestureRecognizer()
    self.instagramBarView.addGestureRecognizer(tapGestureInstagram)
    tapGestureInstagram.addTarget(self, action: #selector(tapInstagram))
    
    let tapGestureSong = UITapGestureRecognizer()
    self.songBarView.addGestureRecognizer(tapGestureSong)
    tapGestureSong.addTarget(self, action: #selector(tapSong))
  }
  
  /// setup the corner radius for Twitch button.
  func setupTwitch() {
    streamBarView.layer.cornerRadius = 2.5
  }
  
  /// setup the corner radius for Youtube button.
  func setupYoutube() {
    videoBarView.layer.cornerRadius = 2.5
  }
  
  /// setup the corner radius for Instagram button.
  func setupInstagram() {
    instagramBarView.layer.cornerRadius = 2.5
  }
  
  /// setup the corner radius for Song button.
  func setupSong() {
    songBarView.layer.cornerRadius = 2.5
  }
  
  /// Call the all function of setup button
  func setupButtons() {
    setupTwitch()
    setupYoutube()
    setupInstagram()
    setupSong()
  }
  
  
  //----------------------------------------------------------------------------
  // MARK: - Action
  //----------------------------------------------------------------------------
  
  @IBAction func menuButtonTapped(_ sender: Any) {
    didTapMenu?()
  }
  
  @IBAction func notificationButtonTapped(_ sender: Any) {
    didTapNotification?()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - OBJC Mehtods
  //----------------------------------------------------------------------------
  
  /// what happens when you press stream button.
  @objc func tapStream() {
    recolorAllView()
    streamBarView.backgroundColor = #colorLiteral(red: 0.07869828492, green: 0.0981830731, blue: 0.1287542284, alpha: 1)
    didTapStream?()
  }
  
  /// what happens when you press video button.
  @objc func tapVideo() {
    recolorAllView()
    videoBarView.backgroundColor = #colorLiteral(red: 0.07869828492, green: 0.0981830731, blue: 0.1287542284, alpha: 1)
    didTapVideo?()
  }
  
  /// what happens when you press instagram button.
  @objc func tapInstagram() {
    recolorAllView()
    instagramBarView.backgroundColor = #colorLiteral(red: 0.07869828492, green: 0.0981830731, blue: 0.1287542284, alpha: 1)
    didTapInstagram?()
  }
  
  /// what happens when you press song button.
  @objc func tapSong() {
    recolorAllView()
    songBarView.backgroundColor = #colorLiteral(red: 0.07869828492, green: 0.0981830731, blue: 0.1287542284, alpha: 1)
    didTapSong?()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  /// Recolor all button when is not tapp.
  private func recolorAllView() {
    let selectedViews: [UIView] =
    [streamBarView, videoBarView, instagramBarView, songBarView]
    for selectedView in selectedViews {
      selectedView.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.1607843137, blue: 0.2117647059, alpha: 1)
    }
  }
}
