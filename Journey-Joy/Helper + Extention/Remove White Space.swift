//
//  remove whiteSpace.swift
//  Airizo
//
//  Created by rana ehtisham on 9/5/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
