//
//  Book.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import SwiftyJSON

struct Book {
    let bookTitle: String
    let chapters: [Chapter]

    static func create(_ bookTitle: String, chapters: [Chapter]) -> Book {
        return Book(bookTitle: bookTitle, chapters: chapters)
    }

}

extension Book: JSONDeserializable {
    
    static func deserialize(_ json: JSON) -> Book {
        var chapters = [Chapter]()
        for chapter in json["Chapters"] {
            chapters.append(Chapter.deserialize(chapter.1))
        }
        return Book.create(json["BookTitle"].stringValue, chapters: chapters)
    }
}

extension Book {
    static var _book: Book?

    static func load() -> Book {
        if _book == nil {
            let json = JSONFileReader.read(fromFile: "gita")!
            _book = Book.deserialize(JSON(data: json))
        }
        return _book!
    }

    static func getChapter(atIndex index: Int) -> Chapter? {
        let book = Book.load()
        switch index {
        case 0..<book.chapters.count:
            return book.chapters[index]
        default:
            return nil
        }
    }

    static func getSection(atChapterIndex chapterIndex: Int, atSectionIndex sectionIndex: Int) -> Section? {
        if let chapter = getChapter(atIndex: chapterIndex) {
            switch sectionIndex {
            case 0..<chapter.sections.count:
                return chapter.sections[sectionIndex]
            default:
                return nil
            }
        }
        return nil
    }
}
