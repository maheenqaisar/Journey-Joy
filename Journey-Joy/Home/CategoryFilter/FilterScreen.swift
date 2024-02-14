//
//  FilterScreen.swift
//  Journey-Joy
//
//  Created by Maheen on 19/01/2024.
//

import UIKit

class FilterScreen: UIViewController, UISearchBarDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var totalNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var firstStack: UIStackView!
    @IBOutlet weak var secondStack: UIStackView!
    @IBOutlet weak var firstContainer: UIView!
    @IBOutlet weak var secondContainer: UIView!
    @IBOutlet weak var thirdContainer: UIView!
    
    // MARK: - Properties
    
    private var tourViewController: TourView?
    var firstViewOriginalHeight: CGFloat!
    var secondViewOriginalHeight: CGFloat!
    var thirdViewOriginalHeight: CGFloat!
    
    // MARK: - View Lifecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firstContainer.isHidden = true
        secondContainer.isHidden = true
        thirdContainer.isHidden = true
        firstStack.isHidden = false
        secondStack.isHidden = false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Save the original heights
        firstViewOriginalHeight = firstView.frame.height
        secondViewOriginalHeight = secondView.frame.height
        thirdViewOriginalHeight = thirdView.frame.height
        
        // Add tap gesture recognizers to the views
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        firstView.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        secondView.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        thirdView.addGestureRecognizer(tapGestureRecognizer3)
        configureNavigationBar()
        configureSearchBar()
        for childViewController in children {
            if let tourVC = childViewController as? TourView {
                tourViewController = tourVC
                break
            }
        }
        for childViewController in children {
            if let personVC = childViewController as? PersonView {
                personVC.totalNumberUpdateHandler = { [weak self] totalNumber in
                    self?.updateTotalNumberLabel(totalNumber)
                }
                break
            }
        }
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedTourOption(_:)), name: NSNotification.Name("SelectedTourOption"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalNumberLabel(_:)), name: Notification.Name("TotalNumberUpdated"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedDate(_:)), name: Notification.Name("SelectedDate"), object: nil)
           
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notification Handling
    
    @objc func updateTotalNumberLabel(_ totalNumber: Int) {
        DispatchQueue.main.async { [self] in
            totalNumberLabel.text = "\(totalNumber) - Persons"
            fourthView.isHidden = false
        }
    }
    
    @objc func handleSelectedTourOption(_ notification: Notification) {
        if let selectedOption = notification.userInfo?["selectedOption"] as? String {
            // Update search bar text
            searchBar.text = selectedOption
            
            // Filter data based on selected option
            tourViewController?.filterContentForSearchText(selectedOption)
            
            // Change search bar icon to heart icon with purple color
            if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
                textFieldInsideSearchBar.leftViewMode = .always
                let locationIcon = UIImage(named: "location")
                let tintedlocationIcon = locationIcon?.withRenderingMode(.alwaysTemplate)
                let locationImageView = UIImageView(image: tintedlocationIcon)
                locationImageView.tintColor = .black
                textFieldInsideSearchBar.leftView = locationImageView
            }
        }
    }
    
    @objc func handleSelectedDate(_ notification: Notification) {
            if let selectedDate = notification.userInfo?["selectedDate"] as? Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMM"
                let dateString = dateFormatter.string(from: selectedDate)
                dateLabel.text = dateString
            }
        }
    
    // MARK: - Search Bar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter data based on entered text
        tourViewController?.filterContentForSearchText(searchText)
    }
    
    func configureSearchBar() {
        // Access the search text field
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            // Make the background color clear
            searchTextField.backgroundColor = UIColor.clear
            // Set the border style to none
            searchTextField.borderStyle = .none
        }
    }
    
    // MARK: - Gesture Recognizer
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            switch tappedView {
            case firstView:
                toggleView(firstView)
                toggleContainerVisibility(firstContainer)
            case secondView:
                toggleView(secondView)
                toggleContainerVisibility(secondContainer)
            case thirdView:
                toggleView(thirdView)
                toggleContainerVisibility(thirdContainer)
            default:
                break
            }
        }
    }
    
    func toggleView(_ view: UIView) {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            let viewsToClose = [self.secondView, self.thirdView].filter { $0 != view }
            viewsToClose.forEach { self.toggleHeight(view: $0, to: 58) }
            let firstToClose = [self.firstView].filter { $0 != view }
            firstToClose.forEach { self.toggleHeight(view: $0, to: 80) }

            if view.bounds.height != self.originalHeight(for: view) {
                self.toggleHeight(view: view, to: self.originalHeight(for: view))
            } else {
                // Hide all containers when toggling to original height
                self.firstContainer.isHidden = true
                self.secondContainer.isHidden = true
                self.thirdContainer.isHidden = true
                self.firstStack.isHidden = false
                self.secondStack.isHidden = false
            }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Height Handling
    
    func originalHeight(for view: UIView) -> CGFloat {
        switch view {
        case firstView:
            return firstViewOriginalHeight
        case secondView:
            return secondViewOriginalHeight
        case thirdView:
            return thirdViewOriginalHeight
        default:
            return 0
        }
    }
    
    func toggleHeight(view: UIView, to height: CGFloat) {
        view.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = height
            }
        }
    }
    
    // MARK: - Container Visibility
    
    func toggleContainerVisibility(_ container: UIView) {
        let allContainers = [firstContainer, secondContainer, thirdContainer]
        
        for containerView in allContainers {
            if containerView == container {
                // Make the selected container visible
                containerView?.isHidden = false
                containerView?.constraints.forEach { constraint in
                    if constraint.firstAttribute == .height {
                        constraint.constant = containerView?.subviews.count == 0 ? 0 : containerView?.intrinsicContentSize.height ?? 0
                    }
                }
            } else {
                // Hide the other containers
                containerView?.isHidden = true
                containerView?.constraints.forEach { constraint in
                    if constraint.firstAttribute == .height {
                        // Set height to 58 pixels when hiding the container
                        constraint.constant = 58
                    }
                }
            }
        }
    }
    
    // MARK: - View Appearance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
        let allViews = [secondView, thirdView]
        
        for view in allViews {
            view?.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.constant = 58
                    secondContainer.isHidden = true
                    thirdContainer.isHidden = true
                    firstStack.isHidden = false
                    secondStack.isHidden = false
                }
            }
        }
        fourthView.isHidden = true
    }
    
    // MARK: - Navigation Bar
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 22) ?? UIFont.systemFont(ofSize: 22)
        ]
        navigationItem.title = "Where to?"
        navigationItem.titleView?.contentMode = .center
    }
    
    // MARK: - Actions
    
    @IBAction func dismissBtn(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "tabBar") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func gotoDetailSearch(_ sender: Any) {
        if let detailScreen = storyboard?.instantiateViewController(withIdentifier: "DetailScreen") {
            detailScreen.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
}
