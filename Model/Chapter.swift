//
//  Chapter.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

struct Chapter {
    let name: String
    let title: String
    let chapterCount: Int
    let subTitle: String?
    let intro: String?
    let outro: String?
    let sections: [Section]
}

extension Chapter: JSONDeserializable {
    static func create(name: String, title: String, chapterCount: Int, subTitle: String?, intro: String?, outro: String?, sections: [Section]) -> Chapter {
        return Chapter(name: name, title: title, chapterCount: chapterCount, subTitle: subTitle, intro: intro, outro: outro, sections: sections)
    }

    static func deserialize(json: JSON) -> Chapter {
        var sections = [Section]()
        for section in json["Sections"] {
            sections.append(Section.deserialize(section.1))
        }
        return Chapter.create(json["Name"].stringValue, title: json["Title"].stringValue, chapterCount: json["ChapterCount"].numberValue as Int, subTitle: json["Subtitle"].stringValue, intro: json["Intro"].stringValue, outro: json["Outro"].stringValue, sections: sections)
    }
}