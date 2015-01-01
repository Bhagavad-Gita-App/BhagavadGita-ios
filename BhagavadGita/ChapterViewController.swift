//
//  ChapterViewController.swift
//  BhagavadGita
//
//  Created by Hari on 12/16/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class ChapterViewController: UITableViewController {

    @IBOutlet weak var sectionsView: UITableView!

    private let _introCellReuseIdentifier: String = "introcell"

    private let _sectionCellReuseIdentifier: String = "sectioncell"

    private let _outroCellReuseIdentifier: String = "outrocell"

    private let _sectionDetailSegueIdentifier: String = "sectionDetail"

    var chapter: Chapter?

    var estimatedRowHeightCache: [String:NSNumber] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = chapter!.title

        var introCell = UINib(nibName: "IntroCell", bundle: nil)
        self.sectionsView.registerNib(introCell, forCellReuseIdentifier: _introCellReuseIdentifier)

        var sectionCell = UINib(nibName: "SectionCell", bundle: nil)
        self.sectionsView.registerNib(sectionCell, forCellReuseIdentifier: _sectionCellReuseIdentifier)

        var outroCell = UINib(nibName: "OutroCell", bundle: nil)
        self.sectionsView.registerNib(outroCell, forCellReuseIdentifier: _outroCellReuseIdentifier)

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == _sectionDetailSegueIdentifier {
            let viewController: SectionViewController = segue.destinationViewController as SectionViewController
            if let selectedRowIndexPath = self.sectionsView.indexPathForSelectedRow() {
                viewController.chapter = self.chapter
                viewController.section = chapter!.sections.filter({ s in s.sectionSerial == selectedRowIndexPath.row + 1 }).first
            }
        }
    }

}

extension ChapterViewController: UITableViewDelegate, UITableViewDataSource {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // if we have outro, total sections will be three, otherwise 2
        return chapter!.outro!.isEmpty ? 2 : 3
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

        var cell: UITableViewCell

        switch indexPath.section {

        case 0: // Intro
            var introCell = self.sectionsView.dequeueReusableCellWithIdentifier(_introCellReuseIdentifier) as IntroCell
            cell = configureIntroCell(introCell, forRowAtIndexPath: indexPath)!

        case 1: // Sections
            var sectionCell = self.sectionsView.dequeueReusableCellWithIdentifier(_sectionCellReuseIdentifier) as SectionCell
            cell = configureSectionCell(sectionCell, forRowAtIndexPath: indexPath)!

        default:    // Outro (and anything else)
            var outroCell = self.sectionsView.dequeueReusableCellWithIdentifier(_outroCellReuseIdentifier) as OutroCell
            cell = configureOutroCell(outroCell, forRowAtIndexPath: indexPath)!

        }

        // put estimated cell height in cache if needed
        if (!isEstimatedRowHeightInCache(indexPath)) {
            let cellSize: CGSize = cell.systemLayoutSizeFittingSize(CGSizeMake(self.view.frame.size.width, 0), withHorizontalFittingPriority: 1000.0, verticalFittingPriority: 50.0)
            putEstimatedCellHeightToCache(indexPath, height: cellSize.height)
        }

        return cell

    }

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let estimatedHeight = getEstimatedCellHeightFromCache(indexPath, defaultHeight: 0)
        if estimatedHeight != 0 {
            return estimatedHeight
        }

        return UITableViewAutomaticDimension
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(_sectionDetailSegueIdentifier, sender: self)
    }

    func configureIntroCell(cell: IntroCell?, forRowAtIndexPath: NSIndexPath) -> IntroCell? {
        cell?.introLabel.text = chapter?.intro
        cell?.introLabel.font = UIFont.systemFontOfSize(14.0)

        cell?.titleLabel.text = chapter?.title
        cell?.titleLabel.font = UIFont.boldSystemFontOfSize(22.0)

        cell?.layoutIfNeeded()

        return cell
    }

    func configureSectionCell(cell: SectionCell?, forRowAtIndexPath indexPath: NSIndexPath) -> SectionCell? {
        var section = chapter!.sections[indexPath.row]
        cell?.speakerLabel?.text = section.speaker
        cell?.speakerLabel.font = UIFont.boldSystemFontOfSize(15.0)

        cell?.contentLabel.text = section.content
        cell?.contentLabel.font = UIFont.boldSystemFontOfSize(17.0)

        cell?.meaningLabel.text = section.meaning
        cell?.meaningLabel.font = UIFont.systemFontOfSize(17.0)

        cell?.layoutIfNeeded()

        return cell
    }

    func configureOutroCell(cell: OutroCell?, forRowAtIndexPath indexPath: NSIndexPath) -> OutroCell? {
        cell?.outroLabel.text = chapter?.outro
        cell?.outroLabel.font = UIFont.systemFontOfSize(14.0)

        cell?.layoutIfNeeded()

        return cell
    }

    // MARK: - estimated height cache methods
    // check if this row's height is in cache
    func isEstimatedRowHeightInCache(indexPath: NSIndexPath) -> Bool {
        return getEstimatedCellHeightFromCache(indexPath, defaultHeight: 0) > 0
    }

    // put height to cache
    func putEstimatedCellHeightToCache(indexPath: NSIndexPath, height: CGFloat) {
        estimatedRowHeightCache["\(indexPath.section)-\(indexPath.row)"] = height
    }

    // get height from cache
    func getEstimatedCellHeightFromCache(indexPath: NSIndexPath, defaultHeight: CGFloat) -> CGFloat {

        if let estimatedHeight = estimatedRowHeightCache["\(indexPath.section)-\(indexPath.row)"] {
            // println("\(indexPath.section)-\(indexPath.row) is cached: \(estimatedHeight)")
            return CGFloat(estimatedHeight)
        }
        // println("\(indexPath.section)-\(indexPath.row) is not cached")
        return defaultHeight
    }

}
