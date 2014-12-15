//
//  ChapterTableViewCell.swift
//  BhagavadGita
//
//  Created by Hari on 12/15/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var subTitle: UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}