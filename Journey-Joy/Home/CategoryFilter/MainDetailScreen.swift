//
//  MainDetailScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 28/01/2024.
//

import UIKit

class MainDetailScreen: UIViewController {

    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var tourImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var detailTour: DetailTour?
    var imageArray: [UIImage] = []
    var currentImageIndex: Int = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        // To hide the navigation bar on a specific view controller
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Update UI with the selected detail tour data
        if let detailTour = detailTour {
            titleLabel.text = detailTour.title
            subtitleLabel.text = detailTour.subtitle
            descriptionLabel.text = detailTour.description
        }
        
        // Initialize your image array with 5 images
        imageArray = [#imageLiteral(resourceName: "slide-one"), #imageLiteral(resourceName: "slide-three"), #imageLiteral(resourceName: "slide-five"), #imageLiteral(resourceName: "slide-two"), #imageLiteral(resourceName: "slide-four")]

        // Set the initial image without animation
        tourImage.image = imageArray[currentImageIndex]

        // Setup swipe gesture recognizers
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        // Setup image count label
        updateImageCountLabel()

    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            showNextImageWithAnimation()
        } else if sender.direction == .right {
            showPreviousImageWithAnimation()
        }
    }

    func showNextImageWithAnimation() {
        let nextImageIndex = (currentImageIndex + 1) % imageArray.count
        updateImageWithAnimation(newImageIndex: nextImageIndex)
    }

    func showPreviousImageWithAnimation() {
        let previousImageIndex = (currentImageIndex - 1 + imageArray.count) % imageArray.count
        updateImageWithAnimation(newImageIndex: previousImageIndex)
    }

    func updateImageWithAnimation(newImageIndex: Int) {
        UIView.transition(with: tourImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.tourImage.image = self.imageArray[newImageIndex]
        }, completion: nil)

        currentImageIndex = newImageIndex
        updateImageCountLabel()
    }

    func updateImageCountLabel() {
        imageCountLabel.text = "\(currentImageIndex + 1)/\(imageArray.count)"
    }
    
    @IBAction func gotoNext(_ sender: Any) {
        // Instantiate the destination view controller
        guard let filterScreen = self.storyboard?.instantiateViewController(withIdentifier: "BookingMainScreen") as? BookingMainScreen else {
            return
        }
        self.navigationController?.pushViewController(filterScreen, animated: true)
        
    }
    
//    @IBAction func gotoBack(_ sender: Any) {
//        if let presentingViewController = self.presentingViewController {
//            // Dismiss the current view controller if it was presented modally
//            presentingViewController.dismiss(animated: true, completion: nil)
//        } else {
//            // Pop the current view controller if it's in a navigation stack
//            self.navigationController?.popViewController(animated: true)
//        }
//    }

}
