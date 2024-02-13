//
//  Check Phone Number.swift
//  Airizo
//
//  Created by rana ehtisham on 10/8/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation

func validate(value: String) -> Bool {
    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}
