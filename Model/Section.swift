//
//  Section.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

struct Section {
    let sectionCount: Int
    let slokaSerial: Int
    let slokasCount: Int
    let slokaNumber: String
    let content: String
    let meaning: String
    let speaker: String?
}

extension Section: JSONDeserializable {
    static func create(sectionCount: Int, slokaSerial: Int, slokasCount: Int, slokaNumber: String, content: String, meaning: String, speaker: String?) -> Section {
        return Section(sectionCount: sectionCount, slokaSerial: slokaSerial, slokasCount: slokasCount, slokaNumber: slokaNumber, content: content, meaning: meaning, speaker: speaker)
    }

    static func deserialize(json: JSON) -> Section {
        return Section.create(json["SectionCount"].numberValue as Int, slokaSerial: json["SectionSerial"].numberValue as Int, slokasCount: json["SlokasCount"].numberValue as Int, slokaNumber: json["SlokaNumber"].stringValue, content: json["Content"].stringValue, meaning: json["Meaning"].stringValue, speaker: json["Speaker"].stringValue)
    }
}