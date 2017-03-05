//
//  JSONFileReader.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

// Inspired from Argo's JSONFileReader class (https://github.com/thoughtbot/Argo/blob/master/ArgoTests/JSON/JSONFileReader.swift)

import Foundation

class JSONFileReader {
    class func read(fromFile file: String) -> Data? {
        let path = Bundle(for: self).path(forResource: file, ofType: "json")

        if path != nil {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
            return data
        }

        return nil
    }
}
