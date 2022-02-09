//
//  VideoViewController.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 24/09/2021.
//



import UIKit


//----------------------------------------------------------------------------
// MARK: - Enum for youtube chanel
//----------------------------------------------------------------------------

enum YoutubeChanel {
  case principale
  case VOD
  case short
}

class VideoViewController: UIViewController {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var youtubeConverter = YoutubeConverter()
  var youtubeVODConverter = YoutubeVODConverter()
  var youtubeShortConverter = YoutubeShortConverter()
  var youtubeChannel: YoutubeChanel = .principale
  
  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------
  
  @IBOutlet weak var youtubeTableView: UITableView!
  
  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    youtubeTableView.register(UINib(nibName: "YoutubeTableViewCell", bundle: nil), forCellReuseIdentifier: "YoutubeCell")
    youtubeTableView.register(UINib(nibName: "YoutubeHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "YoutubeHeaderView")
    youtubeTableView.delegate = self
    youtubeTableView.dataSource = self
    youtubeTableView.allowsSelection = true
    lauchRequest()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  /// Launch the request to collect the videos youtube
  func lauchRequest() {
    youtubeConverter.convert(pageToken: "") { [weak self] result in
      self?.youtubeTableView.reloadData()
    }
  }
  
  /// Check what channel youtube you need the array of items
  /// - Returns: the good videos for the good chanels
  func whatChannelDetails() -> [Item] {
    var videoDetail = youtubeConverter.videoDetails
    
    switch youtubeChannel {
    case .principale:
      videoDetail = youtubeConverter.videoDetails
    case .VOD:
      videoDetail = youtubeVODConverter.videoDetails
    case .short:
      videoDetail = youtubeShortConverter.videoDetails
    }
    return videoDetail
  }
  
  /// If the request is not the first the token is used for collect the next videos on the library of the chanel
  /// - Returns: the correct token
  func whatChannelPageToken() -> String {
    var token = youtubeConverter.pageToken
    
    switch youtubeChannel {
    case .principale:
      token = youtubeConverter.pageToken
    case .VOD:
      token = youtubeVODConverter.pageToken
    case .short:
      token = youtubeShortConverter.pageToken
    }
    return token
  }
}

extension VideoViewController: YoutubeHeaderDelegate {
  
  func didLauchRequestPrincipale() {
    youtubeChannel = .principale
    guard youtubeConverter.videoDetails.isEmpty else {
      youtubeTableView.reloadData()
      return
    }
    youtubeConverter.convert(pageToken: "") { [weak self] result in
      self?.youtubeTableView.reloadData()
    }
  }
  
  func didLauchRequestShort() {
    youtubeChannel = .short
    guard youtubeShortConverter.videoDetails.isEmpty else {
      youtubeTableView.reloadData()
      return
    }
    youtubeShortConverter.convert(pageToken: "") { [weak self] result in
      self?.youtubeTableView.reloadData()
    }
  }
  
  func didLauchRequestVOD() {
    youtubeChannel = .VOD
    guard youtubeVODConverter.videoDetails.isEmpty else {
      youtubeTableView.reloadData()
      return
    }
    youtubeVODConverter.convert(pageToken: "") { [weak self] result in
      self?.youtubeTableView.reloadData()
    }
  }
  
}

//----------------------------------------------------------------------------
// MARK: - Extension Datasource table view
//----------------------------------------------------------------------------

extension VideoViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeCell", for: indexPath) as? YoutubeTableViewCell else {
      print("Error create Cell")
      return UITableViewCell()
    }
    
    let youtubeChannel = whatChannelDetails()
    
    let details = youtubeChannel[indexPath.row]
    
    cell.configure(urlMedia: details.snippet.thumbnails.high.url, caption: details.snippet.title)
    
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let youtubeChannel = whatChannelDetails()
    return youtubeChannel.count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "YoutubeHeaderView") as? YoutubeHeaderView else {
      return UITableViewHeaderFooterView()
    }
    
    headerView.delegate = self
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    let channel = whatChannelDetails()
    
    let token = whatChannelPageToken()
    
    if indexPath.row + 1 == channel.count {
      
      if youtubeChannel == .principale {
        youtubeConverter.convert(pageToken: token) { [weak self] result in
          self?.youtubeTableView.reloadData()
        }
      } else if youtubeChannel == .short {
        youtubeShortConverter.convert(pageToken: token) { [weak self] result in
          self?.youtubeTableView.reloadData()
        }
      } else if youtubeChannel == .VOD {
        youtubeVODConverter.convert(pageToken: token) { [weak self] result in
          print("recherche en cours")
          self?.youtubeTableView.reloadData()
        }
      }
    }
  }
}
//----------------------------------------------------------------------------
// MARK: - Extension UITableViewDelegate
//----------------------------------------------------------------------------

extension VideoViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let indexPathYoutube = youtubeTableView.indexPathForSelectedRow?.row else {
      print("error index path Favorite table view")
      return
    }
    
    let channel = whatChannelDetails()
    
    let selectedPicture = channel[indexPathYoutube]
    
    let url = "https://www.youtube.com/watch?v=" + selectedPicture.id.videoID
    
    guard let url = URL(string: url) else {
      print("error URL")
      return
    }
    UIApplication.shared.open(url)
    
  }
}
