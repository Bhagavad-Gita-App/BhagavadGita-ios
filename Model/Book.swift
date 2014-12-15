//
//  Book.swift
//  BhagavadGita
//
//  Created by Hari on 12/14/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//
struct Book {
    let bookTitle: String
    let chapters: [Chapter]
}

extension Book: JSONDeserializable {
    static func create(bookTitle: String, chapters: [Chapter]) -> Book {
        return Book(bookTitle: bookTitle, chapters: chapters)
    }
    
    static func deserialize(json: JSON) -> Book {
        var chapters = [Chapter]()
        for chapter in json["Chapters"] {
            chapters.append(Chapter.deserialize(chapter.1))
        }
        return Book.create(json["BookTitle"].stringValue, chapters: chapters)
    }
    
    static func load() -> Book {
        let json = JSONFileReader.read(fromFile: "gita")!
        return Book.deserialize(JSON(data: json))
    }
}
