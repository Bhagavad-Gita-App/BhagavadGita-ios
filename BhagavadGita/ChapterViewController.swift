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

    fileprivate let _introCellReuseIdentifier: String = "introcell"

    fileprivate let _sectionCellReuseIdentifier: String = "sectioncell"

    fileprivate let _outroCellReuseIdentifier: String = "outrocell"

    fileprivate let _sectionDetailSegueIdentifier: String = "sectionDetail"

    var chapter: Chapter?

    var estimatedRowHeightCache: [String:NSNumber] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = chapter!.title

        let introCell = UINib(nibName: "IntroCell", bundle: nil)
        self.sectionsView.register(introCell, forCellReuseIdentifier: _introCellReuseIdentifier)

        let sectionCell = UINib(nibName: "SectionCell", bundle: nil)
        self.sectionsView.register(sectionCell, forCellReuseIdentifier: _sectionCellReuseIdentifier)

        let outroCell = UINib(nibName: "OutroCell", bundle: nil)
        self.sectionsView.register(outroCell, forCellReuseIdentifier: _outroCellReuseIdentifier)

        let shareButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ChapterViewController.shareChapter))
        self.navigationItem.rightBarButtonItem = shareButton

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == _sectionDetailSegueIdentifier {
            let viewController: SectionViewController = segue.destination as! SectionViewController
            if let selectedRowIndexPath = self.sectionsView.indexPathForSelectedRow {
                viewController.chapter = self.chapter
                viewController.section = chapter!.sections.filter({ s in s.sectionSerial == selectedRowIndexPath.row + 1 }).first
            }
        }
    }

    func shareChapter() {
        let subject: String = "\(Book.load().bookTitle) - \(chapter!.title)"
        let items: [Any] = [subject as AnyObject, SharingHelper.getSharingUrlFor(chapter!)]
        let uaController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        uaController.setValue(subject, forKey: "subject")
        if let popoverPresentationController = uaController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            //popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection.Up
            popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem
        }
        self.present(uaController, animated: true, completion: nil)
    }

}

extension ChapterViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we have outro, total sections will be three, otherwise 2
        return chapter!.outro!.isEmpty ? 2 : 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {

        case 0: // intro
            return 1

        case 1: // sections
            return chapter!.sections.count

        default: // outro (and anything else)
            return chapter!.outro!.isEmpty ? 0 : 1

        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell

        switch indexPath.section {

        case 0: // Intro
            let introCell = self.sectionsView.dequeueReusableCell(withIdentifier: _introCellReuseIdentifier) as! IntroCell
            cell = configureIntroCell(introCell, forRowAtIndexPath: indexPath)!

        case 1: // Sections
            let sectionCell = self.sectionsView.dequeueReusableCell(withIdentifier: _sectionCellReuseIdentifier) as! SectionCell
            cell = configureSectionCell(sectionCell, forRowAtIndexPath: indexPath)!

        default:    // Outro (and anything else)
            let outroCell = self.sectionsView.dequeueReusableCell(withIdentifier: _outroCellReuseIdentifier) as! OutroCell
            cell = configureOutroCell(outroCell, forRowAtIndexPath: indexPath)!

        }

        // put estimated cell height in cache if needed
        if (!isEstimatedRowHeightInCache(indexPath)) {
            let cellSize: CGSize = cell.systemLayoutSizeFitting(CGSize(width: self.view.frame.size.width, height: 0), withHorizontalFittingPriority: 1000.0, verticalFittingPriority: 50.0)
            putEstimatedCellHeightToCache(indexPath, height: cellSize.height)
        }

        return cell

    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let estimatedHeight = getEstimatedCellHeightFromCache(indexPath, defaultHeight: 0)
        if estimatedHeight != 0 {
            return estimatedHeight
        }

        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: _sectionDetailSegueIdentifier, sender: self)
    }

    func configureIntroCell(_ cell: IntroCell?, forRowAtIndexPath: IndexPath) -> IntroCell? {
        cell?.introLabel.text = chapter?.intro
        cell?.introLabel.font = UIFont.systemFont(ofSize: 14.0)

        cell?.titleLabel.text = chapter?.title
        cell?.titleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)

        cell?.layoutIfNeeded()

        return cell
    }

    func configureSectionCell(_ cell: SectionCell?, forRowAtIndexPath indexPath: IndexPath) -> SectionCell? {
        let section = chapter!.sections[indexPath.row]
        cell?.speakerLabel?.text = section.speaker
        cell?.speakerLabel.font = UIFont.boldSystemFont(ofSize: 15.0)

        cell?.contentLabel.text = section.content
        cell?.contentLabel.font = UIFont.boldSystemFont(ofSize: 17.0)

        cell?.meaningLabel.text = section.meaning
        cell?.meaningLabel.font = UIFont.systemFont(ofSize: 17.0)

        cell?.layoutIfNeeded()

        return cell
    }

    func configureOutroCell(_ cell: OutroCell?, forRowAtIndexPath indexPath: IndexPath) -> OutroCell? {
        cell?.outroLabel.text = chapter?.outro
        cell?.outroLabel.font = UIFont.systemFont(ofSize: 14.0)

        cell?.layoutIfNeeded()

        return cell
    }

    // MARK: - estimated height cache methods
    // check if this row's height is in cache
    func isEstimatedRowHeightInCache(_ indexPath: IndexPath) -> Bool {
        return getEstimatedCellHeightFromCache(indexPath, defaultHeight: 0) > 0
    }

    // put height to cache
    func putEstimatedCellHeightToCache(_ indexPath: IndexPath, height: CGFloat) {
        estimatedRowHeightCache["\(indexPath.section)-\(indexPath.row)"] = height as NSNumber?
    }

    // get height from cache
    func getEstimatedCellHeightFromCache(_ indexPath: IndexPath, defaultHeight: CGFloat) -> CGFloat {

        if let estimatedHeight = estimatedRowHeightCache["\(indexPath.section)-\(indexPath.row)"] {
            // println("\(indexPath.section)-\(indexPath.row) is cached: \(estimatedHeight)")
            return CGFloat(estimatedHeight)
        }
        // println("\(indexPath.section)-\(indexPath.row) is not cached")
        return defaultHeight
    }
    
}
