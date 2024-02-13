//
//  SubString.swift
//  SideMenu
//
//  Created by rana ehtisham on 7/25/19.
//  Copyright © 2019 rana ehtisham. All rights reserved.
//

import Foundation

func getSubString(str:String)->String {

    var myStr : String!
    
    if let i = str.firstIndex(of: "&"){
        myStr.append(String(str.prefix(upTo: i)))
    }else{
      myStr = str
    }
    return myStr
}
