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

    fileprivate let _cellReuseIdentifier: String = "chaptercell"
    fileprivate let _chapterDetailSegueIdentifier: String = "chapterDetail"

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

        let chapterCell = UINib(nibName: "ChapterCell", bundle: nil)
        self.chaptersView.register(chapterCell, forCellReuseIdentifier: _cellReuseIdentifier)
    }

    override func prepare(for segue: (UIStoryboardSegue!), sender: Any?) {
        if segue.identifier == _chapterDetailSegueIdentifier {
            let viewController: ChapterViewController = segue.destination as! ChapterViewController
            if let selectedRowIndexPath = self.chaptersView.indexPathForSelectedRow {
                viewController.chapter = book.chapters.filter({ c in c.chapterSerial == selectedRowIndexPath.row + 1 }).first
            }
        }
    }
}

extension BookViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.book.chapters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChapterCell = self.chaptersView.dequeueReusableCell(withIdentifier: _cellReuseIdentifier) as! ChapterCell
        cell.title?.text = self.book.chapters[indexPath.row].title
        cell.subTitle?.text = self.book.chapters[indexPath.row].subTitle
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: _chapterDetailSegueIdentifier, sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 || indexPath.row == 1 ? 65 : 75
    }
    
}

