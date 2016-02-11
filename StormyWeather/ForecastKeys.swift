//
//  File.swift
//  StormyWeather
//
//  Created by Laryssa Husiak on 2/11/16.
//  Copyright © 2016 Laryssa Husiak. All rights reserved.
//

import Foundation



func valueForAPIKey(keyname:String) -> String {
       let filePath = NSBundle.mainBundle().pathForResource("APIKeys", ofType:"plist")
            print("This is plistpath:", filePath)
    
        let plist = NSDictionary(contentsOfFile:filePath!)
    
    
        let value:String = plist?.objectForKey(keyname) as! String
        return value
    }
