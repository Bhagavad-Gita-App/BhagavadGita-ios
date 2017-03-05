//
//  SharingHelper.swift
//  BhagavadGita
//
//  Created by Hari on 1/1/15.
//  Copyright (c) 2015 floydpink. All rights reserved.
//

import Foundation

struct Constants {
    static let baseSharingUrl = "http://floydpink.github.io/BhagavadGita/share/"
}

class SharingHelper {
    class func getSharingUrlFor(_ chapter: Chapter) -> URL {
        return URL(string: "\(Constants.baseSharingUrl)\(Chapter.getIndexForChapter(chapter)!)/")!
    }
    class func getSharingUrlFor(_ chapter: Chapter, section: Section) -> URL {
        return URL(string: "\(Constants.baseSharingUrl)\(Chapter.getIndexForChapter(chapter)!)/\(Section.getIndexForSectionInChapter(section, chapter: chapter)!)/")!
    }
}
