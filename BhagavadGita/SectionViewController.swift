//
//  SectionViewController.swift
//  BhagavadGita
//
//  Created by Hari on 12/29/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {

    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!

    var chapter: Chapter?
    var section: Section?

    override func viewDidLoad() {
        println(self.chapter)
        println(self.section)
        if let s = section {
            speakerLabel.text = s.speaker
            contentLabel.text = s.content
            meaningLabel.text = s.meaning
        }
    }

}
