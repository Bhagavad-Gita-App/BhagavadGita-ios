//
//  JSONFileReader.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

// Argo's JSONFileReader class (https://github.com/thoughtbot/Argo/blob/master/ArgoTests/JSON/JSONFileReader.swift)

import Foundation

class JSONFileReader {
    class func read(fromFile file: String) -> NSData? {
        let path = NSBundle(forClass: self).pathForResource(file, ofType: "json")
        
        if path != nil {
            let data = NSData(contentsOfFile: path!)!
            return data
        }
        
        return nil
    }
}
