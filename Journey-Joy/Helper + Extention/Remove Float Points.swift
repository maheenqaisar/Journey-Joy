//
//  Remove Float Points.swift
//  Airizo
//
//  Created by rana ehtisham on 9/3/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation

extension Float{
    var cleanValue: String{
        //return String(format: 1 == floor(self) ? "%.0f" : "%.2f", self)
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.0f", self)//
    }
}



