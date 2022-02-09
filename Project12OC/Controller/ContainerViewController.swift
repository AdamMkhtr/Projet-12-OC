//
//  ContainerViewController.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 21/09/2021.
//

import UIKit

class ContainerViewController: UIViewController {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  let menuController = SideMenuViewController(nibName: nil, bundle: nil)
  let homeController = HomeViewController(nibName: nil, bundle: nil)
  let streamController = StreamViewController(nibName: nil, bundle: nil)
  let songController = SongViewController(nibName: nil, bundle: nil)
  let instagramController = InstagramViewController(nibName: nil, bundle: nil)
  let videoController = VideoViewController(nibName: nil, bundle: nil)
  
  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------
  
  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var sideContainer: UIView!
  @IBOutlet weak var baseContainerView: UIView!
  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var leadingMenuConstraint: NSLayoutConstraint!
  
  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureAllMenuContainer()
    configureStreamController()
    setupSideMenu()
    setupBaseContainer()
    animationDisapearRightMenu()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Animation side menu
  //----------------------------------------------------------------------------
  
  /// Anime the vanishing of the right side menu
  func animationDisapearRightMenu() {
    let screenWidth = UIScreen.main.bounds.width
    let disparear = CGAffineTransform(translationX: -screenWidth, y: 0)
    
    UIView.transition(with: self.view, duration: 0.33, options:
                        [.curveEaseOut], animations: {
      self.sideContainer.transform = disparear
    }, completion: {_ in
    })
  }
  

  
  /// Anime the advent of the right side menu
  func animationAppearRightMenu() {
    if sideContainer.isHidden == true {
      sideContainer.isHidden = false
    }
    
    let identity = CGAffineTransform.identity
    
    UIView.transition(with: self.view, duration: 0.33, options:
                        [.curveEaseOut], animations: {
      self.sideContainer.transform = identity
    }, completion: {_ in
    })
  }
  
  /// the shadow view become visible
  func shadowHomeView() {
    shadowView.isHidden = false
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------
  
  /// Setup the animation for the both side menu.
  func setupSideMenu() {
    homeController.didTapMenu = { [weak self] in
      
      self?.animationAppearRightMenu()
      self?.shadowHomeView()
    }
    
    homeController.didTapNotification = { [weak self] in

      self?.shadowHomeView()
    }
  }
  
  /// Setup the button for the base container.
  func setupBaseContainer() {
    homeController.didTapStream = { [weak self] in
      self?.configureStreamController()
    }
    homeController.didTapSong = { [weak self] in
      self?.configureSongController()
    }
    homeController.didTapInstagram = { [weak self] in
      self?.configureInstagramController()
    }
    homeController.didTapVideo = { [weak self] in
      self?.configureVideoController()
    }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  @IBAction func dismissMenu(_ sender: Any) {
    animationDisapearRightMenu()
    shadowView.isHidden = true
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Configure Container
  //----------------------------------------------------------------------------
  
  /// Call the all function for configure container of the app.
  func configureAllMenuContainer() {
    configureHomeController()
    configureSideMenuController()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Top bar container
  //----------------------------------------------------------------------------
  
  /// Configure the view for the home container.
  func configureHomeController() {
    menuView.addSubview(homeController.view)
    addChild(homeController)
    homeController.didMove(toParent: self)
    
    homeController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      homeController.view.topAnchor.constraint(equalTo: menuView.topAnchor),
      homeController.view.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
      homeController.view.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
      homeController.view.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
    ])
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Side menu container
  //----------------------------------------------------------------------------
  
  /// Configure the view for the side menu container.
  func configureSideMenuController() {
    sideContainer.addSubview(menuController.view)
    addChild(menuController)
    menuController.didMove(toParent: self)
    menuController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      menuController.view.topAnchor.constraint(equalTo: sideContainer.topAnchor),
      menuController.view.bottomAnchor.constraint(equalTo: sideContainer.bottomAnchor),
      menuController.view.leadingAnchor.constraint(equalTo: sideContainer.leadingAnchor),
      menuController.view.trailingAnchor.constraint(equalTo: sideContainer.trailingAnchor),
    ])
  }

  //----------------------------------------------------------------------------
  // MARK: - Stream Container
  //----------------------------------------------------------------------------
  
  /// Configure the view for the base container install the stream controller.
  func configureStreamController() {
    baseContainerView.addSubview(streamController.view)
    addChild(streamController)
    streamController.didMove(toParent: self)
    streamController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      streamController.view.topAnchor.constraint(equalTo: baseContainerView.topAnchor),
      streamController.view.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor),
      streamController.view.leadingAnchor.constraint(equalTo: baseContainerView.leadingAnchor),
      streamController.view.trailingAnchor.constraint(equalTo: baseContainerView.trailingAnchor),
    ])
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Song Container
  //----------------------------------------------------------------------------
  
  /// Configure the view for the base container install the song controller.
  func configureSongController() {
    baseContainerView.addSubview(songController.view)
    addChild(songController)
    songController.didMove(toParent: self)
    songController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      songController.view.topAnchor.constraint(equalTo: baseContainerView.topAnchor),
      songController.view.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor),
      songController.view.leadingAnchor.constraint(equalTo: baseContainerView.leadingAnchor),
      songController.view.trailingAnchor.constraint(equalTo: baseContainerView.trailingAnchor),
    ])
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Instagram Container
  //----------------------------------------------------------------------------
  
  /// Configure the view for the base container install the instagram controller.
  func configureInstagramController() {
    baseContainerView.addSubview(instagramController.view)
    addChild(instagramController)
    instagramController.didMove(toParent: self)
    instagramController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      instagramController.view.topAnchor.constraint(equalTo: baseContainerView.topAnchor),
      instagramController.view.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor),
      instagramController.view.leadingAnchor.constraint(equalTo: baseContainerView.leadingAnchor),
      instagramController.view.trailingAnchor.constraint(equalTo: baseContainerView.trailingAnchor),
    ])
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Video Container
  //----------------------------------------------------------------------------
  
  /// Configure the view for the base container install the video controller.
  func configureVideoController() {
    baseContainerView.addSubview(videoController.view)
    addChild(videoController)
    videoController.didMove(toParent: self)
    videoController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      videoController.view.topAnchor.constraint(equalTo: baseContainerView.topAnchor),
      videoController.view.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor),
      videoController.view.leadingAnchor.constraint(equalTo: baseContainerView.leadingAnchor),
      videoController.view.trailingAnchor.constraint(equalTo: baseContainerView.trailingAnchor),
    ])
  }
}
