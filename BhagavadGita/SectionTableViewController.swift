//
//  SectionTableViewController.swift
//  BhagavadGita
//
//  Created by Hari on 12/15/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class SectionTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var sectionsView: UITableView!

    var chapter: Chapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        for section in self.chapter!.sections {
//            println("\(section.slokaCount) -  \(section.content)")
//        }
    }

}
