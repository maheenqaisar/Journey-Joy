//
//  OnboardingScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 04/12/2023.
//

import UIKit

class OnboardingScreen: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!


    // MARK: - Properties

    var slides: [OnboardingSlide] = []

    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Slide Data Setup

        slides = [
            OnboardingSlide(title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: #imageLiteral(resourceName: "3")),
            OnboardingSlide(title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: #imageLiteral(resourceName: "1")),
            OnboardingSlide(title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: #imageLiteral(resourceName: "4"))
        ]

        // MARK: Page Control Setup

        pageControl.numberOfPages = slides.count
    }

    // MARK: - Button Action

     @IBAction func nextBtnClicked(_ sender: UIButton) {
         if currentPage == slides.count - 1 {
             let controller = storyboard?.instantiateViewController(identifier: "WelNC") as! UINavigationController
             controller.modalPresentationStyle = .fullScreen
             controller.modalTransitionStyle = .crossDissolve
             UserDefaults.standard.hasOnboarded = true
             present(controller, animated: true, completion: nil)
         } else {
             currentPage += 1
             let indexPath = IndexPath(item: currentPage, section: 0)
             collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
         }
     }

     // MARK: - View Transition Handling

     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         collectionView.collectionViewLayout.invalidateLayout()
     }
 }

 // MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

 extension OnboardingScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return slides.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
         cell.setup(slides[indexPath.row])
         return cell
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
     }

     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         let width = scrollView.frame.width
         currentPage = Int(scrollView.contentOffset.x / width)
         let indexPath = IndexPath(item: currentPage, section: 0)
         collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
     }
 }
