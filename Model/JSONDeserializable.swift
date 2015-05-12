//
//  JSONDeserializable.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import SwiftyJSON

protocol JSONDeserializable {
    typealias T

    static func deserialize(json: JSON) -> T
}
