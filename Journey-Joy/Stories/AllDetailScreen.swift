//
//  AllDetailScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 21/02/2024.
//

import UIKit

class AllDetailScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var expandCollapseButton: UIButton!
    @IBOutlet weak var moreIconBtn: UIButton!
    
    @IBOutlet weak var reviewSearch: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var suggestioncollectionView: UICollectionView!
    @IBOutlet weak var offercollectionView: UICollectionView!
    
    
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    let imageArray: [UIImage] = [#imageLiteral(resourceName: "slide-three"), #imageLiteral(resourceName: "slide-one"), #imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "Area-Two"), #imageLiteral(resourceName: "slide-three"), #imageLiteral(resourceName: "slide-one"), #imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "Area-Two")]
    
    // Properties
    var isExpanded = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        searchUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        suggestioncollectionView.dataSource = self
        suggestioncollectionView.delegate = self
        offercollectionView.dataSource = self
        offercollectionView.delegate = self
        
        starView.addTopBorder(withColor: .systemGray6, thickness: 2.0)
        firstView.addTopBorder(withColor: .systemGray6, thickness: 2.0)
        secondView.addTopBorder(withColor: .systemGray6, thickness: 2.0)
        thirdView.addTopBorder(withColor: .systemGray6, thickness: 2.0)
        
    }

    // MARK: - UI Setup
    
    private func setupInitialUI()  {
        // Initial setup if needed
        // expandCollapseButton.setTitle("Read more", for: .normal)
        contentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        contentLabel.numberOfLines = 4
    }
    
    private func searchUI() {
        if let searchTextField = reviewSearch.value(forKey: "searchField") as? UITextField {
            // Set background color of the search field to clear
            searchTextField.backgroundColor = UIColor.clear
            
            // Set border style to none to remove the border
            searchTextField.borderStyle = .none
            
            // Clear the background of the search field
            searchTextField.background = UIImage()
            
            // Customize search icon size and color
            if let leftView = searchTextField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.black // Change search icon color to black
                leftView.contentMode = .scaleAspectFit // Adjust icon size
            }
        }
    }
    
    
    // MARK: - Button Action
    
    @IBAction func toggleContent() {
        isExpanded.toggle()
        updateUIForExpansion()
    }
    
    // MARK: - UI Update
    
    private func updateUIForExpansion() {
        UIView.transition(with: contentLabel, duration: 0.4, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            self.contentLabel.numberOfLines = self.isExpanded ? 0 : 4
            self.expandCollapseButton.setTitle(self.isExpanded ? "See Less" : "Read More", for: .normal)
            let moreIconImageName = self.isExpanded ? "chevron.compact.up" : "chevron.compact.down"
            self.moreIconBtn.setImage(UIImage(systemName: moreIconImageName), for: .normal)
        }, completion: nil)
    }
    
    @IBAction func nextTymBtn(_ sender: UIButton) {
        if let viewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "OpenHoursScreen") as? OpenHoursScreen {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyImageCustomCell", for: indexPath) as! MyImageCustomCell
            cell.reviewimageView.image = imageArray[indexPath.item]
            return cell
        } else if collectionView == self.suggestioncollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCustomCell", for: indexPath) as! suggestionCustomCell
            cell.suggestionimageView.image = imageArray[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCustomCell", for: indexPath) as! offerCustomCell
            cell.offerimageView.image = imageArray[indexPath.item]
            return cell
        }
    }
}


class MyImageCustomCell: UICollectionViewCell {
    @IBOutlet weak var reviewimageView: UIImageView!
}

class suggestionCustomCell: UICollectionViewCell {
    @IBOutlet weak var suggestionimageView: UIImageView!
}

class offerCustomCell: UICollectionViewCell {
    @IBOutlet weak var offerimageView: UIImageView!
}
