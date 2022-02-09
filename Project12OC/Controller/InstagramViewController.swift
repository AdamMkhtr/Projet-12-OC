//
//  InstagramViewController.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 24/09/2021.
//

import UIKit

class InstagramViewController: UIViewController {
  
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var instagramDetailsConverter = InstagramDetailsConverter()
  
  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------
  
  @IBOutlet weak var instagramTableView: UITableView!
  
  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.instagramTableView.register(UINib(nibName: "InstagramTableViewCell", bundle: nil), forCellReuseIdentifier: "InstagramCell")
    lauchRequest()
    instagramTableView.delegate = self
    instagramTableView.dataSource = self
    instagramTableView.allowsSelection = true
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  /// Launch the request for collect picture instagram
  func lauchRequest() {
    instagramDetailsConverter.collectDetailsPictures() { [weak self] result in
      self?.instagramTableView.reloadData()
    }
  }
  
}
//----------------------------------------------------------------------------
// MARK: - Extension Datasource table view
//----------------------------------------------------------------------------

extension InstagramViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramCell", for: indexPath) as? InstagramTableViewCell else {
      print("Error create Cell")
      return UITableViewCell()
    }
    let pictureDetail = instagramDetailsConverter.detailsPictures[indexPath.row]
    
    cell.configure(urlMedia: pictureDetail.mediaURL, caption: pictureDetail.caption ?? "")
    
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return instagramDetailsConverter.detailsPictures.count
  }
}

//----------------------------------------------------------------------------
// MARK: - Extension UITableViewDelegate
//----------------------------------------------------------------------------

extension InstagramViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let indexPathInstagram = instagramTableView.indexPathForSelectedRow?.row else {
      print("error index path Favorite table view")
      return
    }
    let selectedPicture = instagramDetailsConverter.detailsPictures[indexPathInstagram]
    
    guard let url = URL(string: selectedPicture.permalink) else {
      print("error URL")
      return
    }
    UIApplication.shared.open(url)
  }
}
