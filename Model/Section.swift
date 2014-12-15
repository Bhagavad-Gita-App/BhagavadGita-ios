//
//  Section.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

struct Section {
    let sectionCount: Int
    let slokaCount: Int
    let content: String
    let meaning: String
    let speaker: String?
}

extension Section: JSONDeserializable {
    static func create(sectionCount: Int, slokaCount: Int, content: String, meaning: String, speaker: String?) -> Section {
        return Section(sectionCount: sectionCount, slokaCount: slokaCount, content: content, meaning: meaning, speaker: speaker)
    }
    
    static func deserialize(json: JSON) -> Section {
        return Section.create(json["SectionCount"].numberValue as Int, slokaCount: json["SlokaCount"].numberValue as Int, content: json["Content"].stringValue, meaning: json["Meaning"].stringValue, speaker: json["Speaker"].stringValue)
    }
}