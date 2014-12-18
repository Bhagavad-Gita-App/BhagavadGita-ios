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

    var sizingIntroCell: ChapterIntroSection?

    var sizingSectionCell: ChapterSectionCell?

    var sizingOutroCell: ChapterOutroSection?

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
        // TODO: Needs some heavy refactoring below
        switch indexPath.section {
        case 0:
            var onceToken: dispatch_once_t = 0
            dispatch_once(&onceToken, {
                self.sizingIntroCell = self.sectionsView.dequeueReusableCellWithIdentifier(self._introCellReuseIdentifier) as? ChapterIntroSection
            })
            sizingIntroCell = configureIntroCell(sizingIntroCell, forRowAtIndexPath: indexPath)
            sizingIntroCell?.layoutIfNeeded()

            let size: CGSize = sizingIntroCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height + 1
        case 2:
            var onceToken: dispatch_once_t = 0
            dispatch_once(&onceToken, {
                self.sizingOutroCell = self.sectionsView.dequeueReusableCellWithIdentifier(self._outroCellReuseIdentifier) as? ChapterOutroSection
            })
            sizingOutroCell = configureOutroCell(sizingOutroCell, forRowAtIndexPath: indexPath)
            sizingOutroCell?.layoutIfNeeded()

            let size: CGSize = sizingOutroCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height + 1
        default:
            var onceToken: dispatch_once_t = 0
            dispatch_once(&onceToken) {
                self.sizingSectionCell = self.sectionsView.dequeueReusableCellWithIdentifier(self._sectionCellReuseIdentifier) as? ChapterSectionCell
            }
            sizingSectionCell = configureSectionCell(sizingSectionCell, forRowAtIndexPath: indexPath)
            sizingSectionCell?.layoutIfNeeded()

            let size: CGSize = sizingSectionCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return size.height + 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // intro
            return 1
        case 1: // sections
            return chapter!.sections.count
        case 2: // outro
            return chapter!.outro!.isEmpty ? 0 : 1
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // Intro
            var cell: ChapterIntroSection = self.sectionsView.dequeueReusableCellWithIdentifier(_introCellReuseIdentifier) as ChapterIntroSection
            return configureIntroCell(cell, forRowAtIndexPath: indexPath)!
        case 2: // Outro
            var cell: ChapterOutroSection = self.sectionsView.dequeueReusableCellWithIdentifier(_outroCellReuseIdentifier) as ChapterOutroSection
            return configureOutroCell(cell, forRowAtIndexPath: indexPath)!
        default:    // Sections
            var cell: ChapterSectionCell = self.sectionsView.dequeueReusableCellWithIdentifier(_sectionCellReuseIdentifier) as ChapterSectionCell
            return configureSectionCell(cell, forRowAtIndexPath: indexPath)!
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
