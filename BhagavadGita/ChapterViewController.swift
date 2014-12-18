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

    private let _introCellReuseIdentifier: String = "introcell"

    private let _sectionCellReuseIdentifier: String = "sectioncell"

    private let _outroCellReuseIdentifier: String = "outrocell"

    struct Static {
        static var sizingIntroCell: ChapterIntroSection?

        static var sizingSectionCell: ChapterSectionCell?

        static var sizingOutroCell: ChapterOutroSection?
    }

    var chapter: Chapter?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = chapter!.title

        var introCell = UINib(nibName: "ChapterIntroCell", bundle: nil)
        self.sectionsView.registerNib(introCell, forCellReuseIdentifier: _introCellReuseIdentifier)

        var sectionCell = UINib(nibName: "ChapterSectionCell", bundle: nil)
        self.sectionsView.registerNib(sectionCell, forCellReuseIdentifier: _sectionCellReuseIdentifier)

        var outroCell = UINib(nibName: "ChapterOutroCell", bundle: nil)
        self.sectionsView.registerNib(outroCell, forCellReuseIdentifier: _outroCellReuseIdentifier)

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // if we have outro, total sections will be three, otherwise 2
        return chapter!.outro!.isEmpty ? 2 : 3
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: // intro
            if Static.sizingIntroCell == nil {
                Static.sizingIntroCell = sectionsView.dequeueReusableCellWithIdentifier(_introCellReuseIdentifier) as? ChapterIntroSection
            }
            Static.sizingIntroCell = configureIntroCell(Static.sizingIntroCell, forRowAtIndexPath: indexPath)
            Static.sizingIntroCell?.layoutIfNeeded()

            let size: CGSize = Static.sizingIntroCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height + 1

        case 1: // sections
            if Static.sizingSectionCell == nil {
                Static.sizingSectionCell = sectionsView.dequeueReusableCellWithIdentifier(_sectionCellReuseIdentifier) as? ChapterSectionCell
            }
            Static.sizingSectionCell = configureSectionCell(Static.sizingSectionCell, forRowAtIndexPath: indexPath)
            Static.sizingSectionCell?.layoutIfNeeded()

            let size: CGSize = Static.sizingSectionCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height + 1

        default:    // outro (and anything else)
            if Static.sizingOutroCell == nil {
                Static.sizingOutroCell = sectionsView.dequeueReusableCellWithIdentifier(_outroCellReuseIdentifier) as? ChapterOutroSection
            }
            Static.sizingOutroCell = configureOutroCell(Static.sizingOutroCell, forRowAtIndexPath: indexPath)
            Static.sizingOutroCell?.layoutIfNeeded()

            let size: CGSize = Static.sizingOutroCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height + 1

        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {

        case 0: // intro
            return 1

        case 1: // sections
            return chapter!.sections.count

        default: // outro (and anything else)
            return chapter!.outro!.isEmpty ? 0 : 1

        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch indexPath.section {

        case 0: // Intro
            var cell: ChapterIntroSection = self.sectionsView.dequeueReusableCellWithIdentifier(_introCellReuseIdentifier) as ChapterIntroSection
            return configureIntroCell(cell, forRowAtIndexPath: indexPath)!

        case 1: // Sections
            var cell: ChapterSectionCell = self.sectionsView.dequeueReusableCellWithIdentifier(_sectionCellReuseIdentifier) as ChapterSectionCell
            return configureSectionCell(cell, forRowAtIndexPath: indexPath)!

        default:    // Outro (and anything else)
            var cell: ChapterOutroSection = self.sectionsView.dequeueReusableCellWithIdentifier(_outroCellReuseIdentifier) as ChapterOutroSection
            return configureOutroCell(cell, forRowAtIndexPath: indexPath)!

        }

    }

    func configureIntroCell(cell: ChapterIntroSection?, forRowAtIndexPath: NSIndexPath) -> ChapterIntroSection? {
        cell?.introLabel.text = chapter?.intro
        cell?.introLabel.font = UIFont.systemFontOfSize(14.0)

        cell?.titleLabel.text = chapter?.title
        cell?.titleLabel.font = UIFont.boldSystemFontOfSize(24.0)

        return cell
    }

    func configureSectionCell(cell: ChapterSectionCell?, forRowAtIndexPath indexPath: NSIndexPath) -> ChapterSectionCell? {
        var section = chapter!.sections[indexPath.row]
        cell?.speakerLabel?.text = section.speaker
        cell?.speakerLabel.font = UIFont.boldSystemFontOfSize(17.0)

        cell?.contentLabel.text = section.content
        cell?.contentLabel.font = UIFont.boldSystemFontOfSize(24.0)

        cell?.meaningLabel.text = section.meaning
        cell?.meaningLabel.font = UIFont.systemFontOfSize(22.0)

        return cell
    }
    
    func configureOutroCell(cell: ChapterOutroSection?, forRowAtIndexPath indexPath: NSIndexPath) -> ChapterOutroSection? {
        cell?.outroLabel.text = chapter?.outro
        cell?.outroLabel.font = UIFont.systemFontOfSize(14.0)

        return cell
    }
}
