//
//  JSONDeserializable.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import SwiftyJSON

protocol JSONDeserializable {
    associatedtype T

    static func deserialize(_ json: JSON) -> T
}
