//
//  ChapterViewController.swift
//  BhagavadGita
//
//  Created by Hari on 12/16/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class ChapterViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var sectionsView: UITableView!

    let _introCellReuseIdentifier: String = "intro"

    let _sectionCellReuseIdentifier: String = "section"

    let _outroCellReuseIdentifier: String = "outro"

    var chapter: Chapter?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = chapter!.title

        var introCell = UINib(nibName: "ChapterIntroCell", bundle: nil)
        self.sectionsView.registerNib(introCell, forCellReuseIdentifier: _introCellReuseIdentifier)

        self.sectionsView.registerClass(UITableViewCell.self, forCellReuseIdentifier: _sectionCellReuseIdentifier)

        var outroCell = UINib(nibName: "ChapterOutroCell", bundle: nil)
        self.sectionsView.registerNib(outroCell, forCellReuseIdentifier: _outroCellReuseIdentifier)

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 || section == 2 ? 1 : chapter!.sections.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var cell: ChapterIntroSection = self.sectionsView.dequeueReusableCellWithIdentifier(_introCellReuseIdentifier) as ChapterIntroSection
            cell.introLabel.text = chapter?.intro
            cell.titleLabel.text = chapter?.title
            return cell
        case 2:
            var cell: ChapterOutroSection = self.sectionsView.dequeueReusableCellWithIdentifier(_outroCellReuseIdentifier) as ChapterOutroSection
            cell.outroLabel.text = chapter?.outro
            return cell
        default:
            var cell: UITableViewCell = self.sectionsView.dequeueReusableCellWithIdentifier(_sectionCellReuseIdentifier) as UITableViewCell
            cell.textLabel?.text = chapter!.sections[indexPath.row].content
            return cell
        }

    }
    

}
