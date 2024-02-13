//
//  Buttons.swift
//  UnFadedCkientSide
//
//  Created by Shami Mac on 25/05/2021.
//

import UIKit

@IBDesignable
class HomeButtons: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusAndShadow()
    }
    
    func setRadiusAndShadow() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.masksToBounds = false
        
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.3038981541, green: 0.3038981541, blue: 0.3038981541, alpha: 1)
    }
    
    
}

@IBDesignable
class RoundedImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}


