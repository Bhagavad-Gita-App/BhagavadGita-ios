//
//  Section.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import SwiftyJSON

struct Section {
    let sectionCount: Int
    let sectionSerial: Int
    let slokasCount: Int
    let slokaNumber: String
    let content: String
    let meaning: String
    let speaker: String?
    
    static func create(sectionCount: Int, sectionSerial: Int, slokasCount: Int, slokaNumber: String, content: String, meaning: String, speaker: String?) -> Section {
        return Section(sectionCount: sectionCount, sectionSerial: sectionSerial, slokasCount: slokasCount, slokaNumber: slokaNumber, content: content, meaning: meaning, speaker: speaker)
    }

}

extension Section: JSONDeserializable {
    static func deserialize(json: JSON) -> Section {
        return Section.create(json["SectionCount"].numberValue as Int, sectionSerial: json["SectionSerial"].numberValue as Int, slokasCount: json["SlokasCount"].numberValue as Int, slokaNumber: json["SlokaNumber"].stringValue, content: json["Content"].stringValue, meaning: json["Meaning"].stringValue, speaker: json["Speaker"].stringValue)
    }
}

extension Section {
    static func getIndexForSectionInChapter(section: Section, chapter: Chapter) -> Int? {
        var index: Int?
        for (i, value) in enumerate(chapter.sections) {
            if section.sectionSerial == value.sectionSerial {
                index = i
                break
            }
        }
        return index
    }
}