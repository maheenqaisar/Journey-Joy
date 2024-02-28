//
//  MainDetailScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 28/01/2024.
//

import UIKit

class MainDetailScreen: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var faqstableView: UITableView!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var tourImage: UIImageView!
    
    @IBOutlet weak var organizationView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet weak var StoryImage: UIImageView!
    
    var detailTour: DetailTour?
    var imageArray: [UIImage] = []
    var currentImageIndex: Int = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let detailTour = detailTour {
            titleLabel.text = detailTour.title
            subtitleLabel.text = detailTour.subtitle
            descriptionLabel.text = detailTour.description
        }
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        StoryImage.isUserInteractionEnabled = true
        StoryImage.addGestureRecognizer(tapGestureRecognizer)

    }
    
    @objc func imageTapped() {
        if let nextScreenVC = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "AllDetailScreen") as? AllDetailScreen {
            navigationController?.pushViewController(nextScreenVC, animated: true)
        }
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
    
    // MARK: - UITableViewDataSource
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return faqsArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "FAQSTableViewCell", for: indexPath) as! FAQSTableViewCell
           let ques = faqsArray[indexPath.row]
           cell.faqsNameLabel.text = ques.name
           cell.accessoryType = .disclosureIndicator
           return cell
       }
       
       // MARK: - UITableViewDelegate
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedItem = faqsArray[indexPath.row] // Retrieve selected item
           let storyboard = UIStoryboard(name: "FAQS", bundle: nil)
           let nextVC = storyboard.instantiateViewController(withIdentifier: "FAQSScreen") as! FAQSScreen
           nextVC.selectedIndex = indexPath.row + 1
           nextVC.navigationItem.title = selectedItem.name
           navigationController?.pushViewController(nextVC, animated: true)
       }


}
