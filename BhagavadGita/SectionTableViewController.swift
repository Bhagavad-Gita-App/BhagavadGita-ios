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

    let _cellReuseIdentifier: String = "cell"

    var chapter: Chapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = chapter!.title

        self.sectionsView.registerClass(UITableViewCell.self, forCellReuseIdentifier: _cellReuseIdentifier)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapter!.sections.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.sectionsView.dequeueReusableCellWithIdentifier(_cellReuseIdentifier) as UITableViewCell
        cell.textLabel?.text = chapter!.sections[indexPath.row].content
        return cell
    }

}
