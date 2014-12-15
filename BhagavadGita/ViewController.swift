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
    
    var _book: Book?
    
    var book: Book {
        get {
            return _book ?? Book.load()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _book = Book.load()
        
        self.chaptersView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.book.chapters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.chaptersView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel?.text = "(\(self.book.chapters[indexPath.row].chapterCount)) - \(self.book.chapters[indexPath.row].title)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

