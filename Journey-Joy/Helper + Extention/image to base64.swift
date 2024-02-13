//
//  image to base64.swift
//  SideMenu
//
//  Created by rana ehtisham on 8/6/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

func ConvertImageToBase64String (img: UIImage) -> String {
    let imageData:NSData = img.jpegData(compressionQuality: 0.5)! as NSData //UIImagePNGRepresentation(img)
    let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
    return imgString
}
