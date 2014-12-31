//
//  BookViewController.swift
//  BhagavadGita
//
//  Created by Hari on 12/9/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class BookViewController: UITableViewController {

    @IBOutlet weak var chaptersView: UITableView!

    private let _cellReuseIdentifier: String = "chaptercell"
    private let _chapterDetailSegueIdentifier: String = "chapterDetail"

    var _book: Book?

    var book: Book {
        get {
            return _book ?? Book.load()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _book = Book.load()

        self.title = book.bookTitle

        var chapterCell = UINib(nibName: "ChapterCell", bundle: nil)
        self.chaptersView.registerNib(chapterCell, forCellReuseIdentifier: _cellReuseIdentifier)
    }

    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject?) {
        if segue.identifier == _chapterDetailSegueIdentifier {
            let viewController: ChapterViewController = segue.destinationViewController as ChapterViewController
            if let selectedRowIndexPath = self.chaptersView.indexPathForSelectedRow() {
                viewController.chapter = book.chapters.filter({ c in c.chapterCount == selectedRowIndexPath.row + 1 }).first
            }
        }
    }
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.book.chapters.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ChapterCell = self.chaptersView.dequeueReusableCellWithIdentifier(_cellReuseIdentifier) as ChapterCell
        cell.title?.text = self.book.chapters[indexPath.row].title
        cell.subTitle?.text = self.book.chapters[indexPath.row].subTitle
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(_chapterDetailSegueIdentifier, sender: self)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row == 0 || indexPath.row == 1 ? 65 : 75
    }

}

