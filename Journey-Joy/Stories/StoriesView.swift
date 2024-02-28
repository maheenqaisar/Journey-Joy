//
//  StoriesView.swift
//  Journey-Joy
//
//  Created by Maheen on 21/02/2024.
//

import UIKit

class StoriesView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    var storiesArray: [StoryDetail] = []

    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storiesCollectionView.register(UINib(nibName: "StoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        
        storiesArray = [
               StoryDetail(title: "Hunza", image: #imageLiteral(resourceName: "slide-four")),
               StoryDetail(title: "Murree", image: #imageLiteral(resourceName: "slide-four")),
               StoryDetail(title: "Skardu", image: #imageLiteral(resourceName: "slide-four")),
               StoryDetail(title: "Hunza", image: #imageLiteral(resourceName: "slide-four")),
               StoryDetail(title: "Murree", image: #imageLiteral(resourceName: "slide-four")),
               StoryDetail(title: "Skardu", image: #imageLiteral(resourceName: "slide-four")),
               StoryDetail(title: "Hunza", image: #imageLiteral(resourceName: "slide-four")),
               StoryDetail(title: "Murree", image: #imageLiteral(resourceName: "slide-four"))
               // Add more items as needed
           ]
        
        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        
        mainView.addBottomBorder(withColor: .systemGray6, thickness: 2.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCell", for: indexPath) as! StoriesCollectionViewCell
        
        let story = storiesArray[indexPath.item]
        cell.StoryimageView.image = story.image
        cell.label.text = story.title
        
        return cell
    }
}

