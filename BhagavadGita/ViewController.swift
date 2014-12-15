//
//  ViewController.swift
//  BhagavadGita
//
//  Created by Hari on 12/9/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chaptersView: UITableView!

    let _cellReuseIdentifier: String = "cell"

    var _book: Book?

    var book: Book {
        get {
            return _book ?? Book.load()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _book = Book.load()

        var chapterCell = UINib(nibName: "ChapterTableViewCell", bundle: nil)
        self.chaptersView.registerNib(chapterCell, forCellReuseIdentifier: _cellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.book.chapters.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ChapterTableViewCell = self.chaptersView.dequeueReusableCellWithIdentifier(_cellReuseIdentifier) as ChapterTableViewCell
        cell.title?.text = self.book.chapters[indexPath.row].title
        cell.subTitle?.text = self.book.chapters[indexPath.row].subTitle
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

}

