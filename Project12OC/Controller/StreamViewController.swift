//
//  StreamViewController.swift
//  LocklearApp
//
//  Created by Adam Mokhtar on 24/09/2021.
//

import UIKit

class StreamViewController: UIViewController {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var countdownTimer = Timer()
  let days = ["Lun","Mar","Mer","Jeu","Vend","Sam","Dim"]
  let dayOfToday = Date().dayOfWeek()
  
  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------
  
  @IBOutlet weak var rightView: UIView!
  @IBOutlet weak var leftView: UIView!
  @IBOutlet weak var dayTimerLabel: UILabel!
  @IBOutlet weak var hourTimerLabel: UILabel!
  @IBOutlet weak var minTimerLabel: UILabel!
  @IBOutlet weak var secTimerLabel: UILabel!
  @IBOutlet weak var calendarCollectionView: UICollectionView!
  @IBOutlet weak var titleView: UIView!
  @IBOutlet weak var calendarCollectionViewFlowLayout: UICollectionViewFlowLayout!

  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    calendarCollectionView.delegate = self
    calendarCollectionView.dataSource = self
    calendarCollectionView.register(UINib(nibName:"StreamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StreamCell")
    calendarCollectionView.isPagingEnabled = false
    startTimer()
    setupCornerRadius()
    setupGestureStream()
    calendarCollectionViewFlowLayout.minimumLineSpacing = 0
    //   scrollToDayOfToday()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  /// Setup the gesture recognizer for the button next and previous day.
  func setupGestureStream() {
    let tapGestureLeft = UITapGestureRecognizer()
    self.leftView.addGestureRecognizer(tapGestureLeft)
    tapGestureLeft.addTarget(self, action: #selector(clickLeft))
    let tapGestureRight = UITapGestureRecognizer()
    self.rightView.addGestureRecognizer(tapGestureRight)
    tapGestureRight.addTarget(self, action: #selector(clickRight))
  }

  /// Setup the corner radius for the views.
  func setupCornerRadius() {
    titleView.layer.cornerRadius = 8
    leftView.layer.cornerRadius = 4
    rightView.layer.cornerRadius = 4
  }
  

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /// Collect the string of dayOfToday for return shortcut string.
  /// - Returns: shortcut of the day of today.
  private func shortStringDay() -> String {
    var shortStringDay = ""
    if dayOfToday == "Lundi" || dayOfToday == "Monday" {
      shortStringDay = "Lun"
    }
    else if dayOfToday == "Mardi" || dayOfToday == "Tuesday" {
      shortStringDay = "Mar"
    }
    else if dayOfToday == "Mercredi" || dayOfToday == "Wednesday" {
      shortStringDay = "Mer"
    }
    else if dayOfToday == "Jeudi" || dayOfToday == "Thursday" {
      shortStringDay = "Jeu"
    }
    else if dayOfToday == "Vendredi" || dayOfToday == "Friday" {
      shortStringDay = "Vend"
    }
    else if dayOfToday == "Samedi" || dayOfToday == "Saturday" {
      shortStringDay = "Sam"
    }
    else if  dayOfToday == "Dimanche" || dayOfToday == "Sunday" {
      shortStringDay = "Dim"
    }
    return shortStringDay
  }

  /// Check what is the last day on the collection view
  /// - Returns: the index of the last cell
  private func getLastVisibleIndexPath() -> IndexPath? {
    let visibleRect = CGRect(origin: calendarCollectionView.contentOffset,
                             size: calendarCollectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX + (visibleRect.midX / 2 - 15), y: visibleRect.midY)
    return calendarCollectionView.indexPathForItem(at: visiblePoint)
  }

  /// Check what is the first day on the collection view
  /// - Returns: the index of the first cell
  private func getFirstVisibleIndexPath() -> IndexPath? {
    let visibleRect = CGRect(origin: calendarCollectionView.contentOffset,
                             size: calendarCollectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX - (visibleRect.midX / 2), y: visibleRect.midY)
    return calendarCollectionView.indexPathForItem(at: visiblePoint)
  }

  //----------------------------------------------------------------------------
  // MARK: - click swipe collectionView
  //----------------------------------------------------------------------------

  /// Scroll to the next cell
  @objc func clickRight() {
    guard let currentindexPath = getLastVisibleIndexPath() else  { return }
    let nextItem: IndexPath = IndexPath(row: currentindexPath.row + 1, section: currentindexPath.section)
    
    guard nextItem.row < days.count else {
      return
    }

    print(nextItem)
    self.calendarCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
  }

  /// Scroll to the previous cell
  @objc func clickLeft() {
    guard let currentindexPath = getFirstVisibleIndexPath() else  { return }
    let previousItem: IndexPath = IndexPath(row: currentindexPath.row - 1, section: currentindexPath.section)
    
    guard previousItem.row <= days.count else {
      return
    }
    self.calendarCollectionView.scrollToItem(at: previousItem, at: .left, animated: true)
  }

  //----------------------------------------------------------------------------
  // MARK: - What date i need for the time interval
  //----------------------------------------------------------------------------

  ///  Check if the next stream is today or tomorow
  private var whatDate: TimeInterval {
    let todayDateStream =
    Calendar.current.date(bySettingHour: 20, minute: 30, second: 0, of: Date())!
    let today = Date()
    
    let tomorrow = Date.tomorrow
    let date =
    Calendar.current.date(bySettingHour: 20, minute: 30, second: 0, of: tomorrow)!
    
    guard today < todayDateStream else {
      let intervalTomorrow = date.timeIntervalSinceNow - today.timeIntervalSinceNow
      return intervalTomorrow
    }
    let intervalToday = todayDateStream.timeIntervalSinceNow - today.timeIntervalSinceNow
    return intervalToday
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Timer
  //----------------------------------------------------------------------------

  /// Manage de timer.
  func startTimer() {
    
    
    countdownTimer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(stringFromTimeInterval),
                                          userInfo: nil,
                                          repeats: true)
  }
  
  @objc func stringFromTimeInterval()  {
    let intervalle = whatDate
    let interval = Int(intervalle)
    let seconds = interval % 60
    let minutes = (interval / 60) % 60
    let hours = (interval / 3600) % 24
    let days = (interval / 86400)
    let stringDays = String(format: "%02d:", days)
    let stringHours = String(format: "%02d:", hours)
    let stringMin = String(format: "%02d:", minutes)
    let stringSec = String(format: "%02d", seconds)
    dayTimerLabel.text =  stringDays
    hourTimerLabel.text = stringHours
    minTimerLabel.text =  stringMin
    secTimerLabel.text =  stringSec
  }
}

//----------------------------------------------------------------------------
// MARK: - Extension CollectionView DataSource
//----------------------------------------------------------------------------

extension StreamViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let itemToShow = days[indexPath.row % days.count]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StreamCell", for: indexPath) as? StreamCollectionViewCell else {
      print("Error create Cell")
      return UICollectionViewCell()
    }
    cell.titleLabel.text = itemToShow
    cell.isCurrentDay = itemToShow == shortStringDay() ? true : false
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
#warning("ICI PROBLEME J'AI FAIS days.count * 10 ")
    return days.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}

//----------------------------------------------------------------------------
// MARK: - Extension CollectionView Delegate
//----------------------------------------------------------------------------

extension StreamViewController : UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let pageWidth = calendarCollectionView.bounds.size.width / 3
    let minimumSpacing: CGFloat = 10
    var cellToSwipe = Int(floor(scrollView.contentOffset.x / (pageWidth + minimumSpacing) + 0.5))
    let daysCount = days.count
    if cellToSwipe < 0 {
      cellToSwipe = 0
    } else if cellToSwipe >= daysCount  {
      cellToSwipe = daysCount - 1
    }

    let indexPath = IndexPath(row: cellToSwipe, section: 0)
    calendarCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
  }
}

//----------------------------------------------------------------------------
// MARK: - Extension CollectionView Flow Layout
//----------------------------------------------------------------------------

extension StreamViewController : UICollectionViewDelegateFlowLayout {


  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: (collectionView.bounds.size.width / 3) ,
                  height: collectionView.bounds.size.height)
  }
}

//    private func indexOfMajorCell() -> Int {
//        let itemWidth = calendarCollectionView.bounds.size.width / 4 - 4
//        let proportionalOffset = calendarCollectionViewFlowLayout.collectionView!.contentOffset.x / itemWidth
//        let index = Int(round(proportionalOffset))
//        let safeIndex = max(0, min(days.count - 1, index))
//        return safeIndex
//    }
//
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        indexOfCellBeforeDragging = indexOfMajorCell()
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        // Stop scrollView sliding:
//        targetContentOffset.pointee = scrollView.contentOffset
//
//        // calculate where scrollView should snap to:
//        let indexOfMajorCell = self.indexOfMajorCell()
//
//        // calculate conditions:
//        let swipeVelocityThreshold: CGFloat = 0.4 // after some trail and error
//        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < days.count && velocity.x > swipeVelocityThreshold
//        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
//        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
//        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
//
//        if didUseSwipeToSkipCell {
//
//            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
//            let toValue = calendarCollectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)
//
//            // Damping equal 1 => no oscillations => decay animation:
//          UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
//                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
//                scrollView.layoutIfNeeded()
//            }, completion: nil)
//
//        } else {
//            // This is a much better way to scroll to a cell:
//            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
//          calendarCollectionViewFlowLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
//    }
