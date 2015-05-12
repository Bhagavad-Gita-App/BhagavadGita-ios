//
//  Chapter.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import SwiftyJSON

struct Chapter {
    let name: String
    let title: String
    let chapterSerial: Int
    let slokasCount: Int
    let subTitle: String?
    let intro: String?
    let outro: String?
    let sections: [Section]
}

extension Chapter: JSONDeserializable {
    static func create(name: String, title: String, chapterSerial: Int, slokasCount: Int, subTitle: String?, intro: String?, outro: String?, sections: [Section]) -> Chapter {
        return Chapter(name: name, title: title, chapterSerial: chapterSerial, slokasCount: slokasCount, subTitle: subTitle, intro: intro, outro: outro, sections: sections)
    }

    static func deserialize(json: JSON) -> Chapter {
        var sections = [Section]()
        for section in json["Sections"] {
            sections.append(Section.deserialize(section.1))
        }
        return Chapter.create(json["Name"].stringValue, title: json["Title"].stringValue, chapterSerial: json["ChapterSerial"].numberValue as Int, slokasCount: json["SlokasCount"].numberValue as Int, subTitle: json["Subtitle"].stringValue, intro: json["Intro"].stringValue, outro: json["Outro"].stringValue, sections: sections)
    }
}

extension Chapter {
    static func getIndexForChapter(chapter: Chapter) -> Int? {
        var index: Int?
        var book = Book.load()
        for (i, value) in enumerate(book.chapters) {
            if chapter.chapterSerial == value.chapterSerial {
                index = i
                break
            }
        }
        return index
    }
}