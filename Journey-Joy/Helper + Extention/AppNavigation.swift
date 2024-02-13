//
//  AppNavigation.swift
//  UnFadedClientSide
//
//  Created by Shami Mac on 18/07/2021.
//

import UIKit


enum AppNavigationType {
    case WHITE
    case BLACK
}

class AppNavigation: UIViewController {
    
    // MARK: - IBOutlets
    
    // MARK: - Variables
    var type: AppNavigationType = .BLACK {
        didSet {
            cutomizeNavigationBar()
        }
    }
    
    // MARK: - Constants
    let backBtn = UIButton(type: .system)
    
    lazy var leftBarItem: Array = { () -> [UIBarButtonItem] in
        backBtn.setImage(UIImage(named: "BackIcon"), for: .normal)
        backBtn.tintColor =  type == .WHITE ? .black : .white
        backBtn.imageView?.contentMode = .scaleAspectFit
        backBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
       // backBtn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
       // backBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
        paddingView.addSubview(backBtn)
        backBtn.frame = paddingView.bounds.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        let mbarButton = UIBarButtonItem(customView: paddingView)

        // Create Custom View
       // let mbarButton = UIBarButtonItem(customView: backBtn)
        return [mbarButton]
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Navigation Settings
        cutomizeNavigationBar()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    //MARK: Round Corners
    func roundedCorners(corners : UIRectCorner, radius : CGFloat) {
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    func cutomizeNavigationBar() {
        self.navigationItem.setLeftBarButtonItems(self.leftBarItem, animated: false)
        self.navigationController?.navigationBar.barTintColor = type == .BLACK ? #colorLiteral(red: 0.09803921569, green: 0.007843137255, blue: 0.01568627451, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.tintColor = type == .BLACK ? .white : .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: type == .BLACK ? UIColor.white : UIColor.black]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
