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
    class func getSharingUrlFor(#chapter: Chapter) -> NSURL {
        return NSURL(string: "\(Constants.baseSharingUrl)\(Chapter.getIndexForChapter(chapter)!)/")!
    }
    class func getSharingUrlFor(#chapter: Chapter, section: Section) -> NSURL {
        return NSURL(string: "\(Constants.baseSharingUrl)\(Chapter.getIndexForChapter(chapter)!)/\(Section.getIndexForSectionInChapter(section, chapter: chapter)!)/")!
    }
}