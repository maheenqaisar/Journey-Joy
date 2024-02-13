//
//  Safe Area.swift
//  DownTown Slice
//
//  Created by rana ehtisham on 9/13/19.
//  Copyright © 2019 tektiks inovation. All rights reserved.
//

import Foundation
import UIKit

var hasSafeArea: Bool {
    if #available(iOS 11.0, *) {
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first,
           let topPadding = windowScene.windows.first?.safeAreaInsets.top {
            return topPadding > 24
        }
    }
    return false
}
