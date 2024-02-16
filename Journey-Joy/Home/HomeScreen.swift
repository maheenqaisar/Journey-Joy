//
//  HomeScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 03/01/2024.
//

import UIKit

class HomeScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CustomSegmentedControlDelegate {

    // MARK: - Outlets

    @IBOutlet weak var slidecollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var tripView: UIView!
    @IBOutlet weak var offerView: UIView!

    @IBOutlet weak var groupcollectionView: UICollectionView!
    @IBOutlet weak var tripscollectionView: UICollectionView!
    @IBOutlet weak var offerscollectionView: UICollectionView!

    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl! {
        didSet {
            let segmentData: [(title: String, icon: UIImage)] = [
                ("All", UIImage(systemName: "sparkles") ?? UIImage()),
                ("Groups", UIImage(systemName: "person.2.gobackward") ?? UIImage()),
                ("Trips", UIImage(systemName: "tropicalstorm") ?? UIImage()),
                ("Offers", UIImage(systemName: "l.joystick.tilt.right") ?? UIImage()),
            ]
            interfaceSegmented.setSegmentData(segmentData: segmentData)
        }
    }

    // MARK: - Properties

    var slides: [HeaderSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    var timer: Timer?

    let groupData = ["Travel Hunter", "Frostpeak Haven", "Echo Peaks", "Frozen Horizon", "Glacier Haven"]
    let tripsData = ["Trip 1", "Trip 2", "Trip 3", "Trip 4", "Trip 5"]
    let offersData = ["Offer 1", "Offer 2", "Offer 3", "Offer 4", "Offer 5"]

    // MARK: - View Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        // To hide the navigation bar on a specific view controller
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Slide Data Setup
        slides = [
            HeaderSlide(title: "Travel Hunter Exclusive 50% Off for Hunza (Minimum 4 persons)", image: #imageLiteral(resourceName: "Area-Two")),
            HeaderSlide(title: "Discover Hunza in Style: Squad special 50% Off Hunza Journey!", image: #imageLiteral(resourceName: "Area-One")),
            HeaderSlide(title: "Gather Your Gang: 50% Off on Exclusive Hunza Expedition!", image: #imageLiteral(resourceName: "Area-Three"))
        ]
        
        // Page Control Setup
        pageControl.numberOfPages = slides.count
        
        // Timer Setup for Automatic Animation
        startTimer()
        interfaceSegmented.delegate = self
    }
    
    func change(to index: Int) {
            // Handle the segment change
            switch index {
            case 1: // "Groups"
                scrollAndAnimate(to: groupView, collectionView: groupcollectionView)
            case 2: // "Trips"
                scrollAndAnimate(to: tripView, collectionView: tripscollectionView)
            case 3: // "Offers"
                scrollAndAnimate(to: offerView, collectionView: offerscollectionView)
            default:
                break
            }
        }

        // MARK: - Animation and Scrolling Methods

        func scrollAndAnimate(to view: UIView, collectionView: UICollectionView) {
            // Scroll to the corresponding view
            let scrollRect = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: 1, height: 1)
            collectionView.scrollRectToVisible(scrollRect, animated: true)

            // Add your animation or blink effect to the specified view
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0.5 // Adjust alpha or other properties as needed
            }) { (_) in
                UIView.animate(withDuration: 0.3) {
                    view.alpha = 1.0
                }
            }
        }

    // MARK: - Timer Methods

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(animateCarousel), userInfo: nil, repeats: true)
    }

    @objc func animateCarousel() {
        let nextPage = (currentPage + 1) % slides.count
        scrollToPage(page: nextPage)
    }

    func scrollToPage(page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        slidecollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentPage = page
    }

    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case slidecollectionView:
            return slides.count
        case groupcollectionView:
            return groupData.count
        case tripscollectionView:
            return tripsData.count
        case offerscollectionView:
            return offersData.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellIdentifier: String

        switch collectionView {
        case slidecollectionView:
            cellIdentifier = HeaderCell.identifier
        case groupcollectionView:
            cellIdentifier = HomeScreen.groupCellIdentifier
        case tripscollectionView:
            cellIdentifier = HomeScreen.tripCellIdentifier
        case offerscollectionView:
            cellIdentifier = HomeScreen.offerCellIdentifier
        default:
            cellIdentifier = ""
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        configureCell(cell, with: indexPath.item)
        return cell
    }

    func configureCell(_ cell: UICollectionViewCell, with index: Int) {
        if let headerCell = cell as? HeaderCell {
            headerCell.setup(slides[index])
        } else if let groupCell = cell as? MyGroupCollectionViewCell {
            groupCell.label.text = groupData[index]
        } else if let tripCell = cell as? MyTripCollectionViewCell {
            tripCell.label.text = tripsData[index]
        } else if let offerCell = cell as? MyOfferCollectionViewCell {
            offerCell.label.text = offersData[index]
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Pause the timer when the user starts dragging
        timer?.invalidate()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Resume the timer when the user stops dragging
        startTimer()
    }

    deinit {
        timer?.invalidate()
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        // Assuming FilterScreen is the storyboard ID of your FilterScreen ViewController
        if let filterScreen = self.storyboard?.instantiateViewController(withIdentifier: "FilterScreen") {
            //filterScreen.hidesBottomBarWhenPushed = true
            //filterScreen.navigationController?.isNavigationBarHidden = false
            self.navigationController?.pushViewController(filterScreen, animated: true)
        }
    }

}

extension HomeScreen {
    static let groupCellIdentifier = "MyGroupCollectionViewCell"
    static let tripCellIdentifier = "MyTripCollectionViewCell"
    static let offerCellIdentifier = "MyOfferCollectionViewCell"
}
