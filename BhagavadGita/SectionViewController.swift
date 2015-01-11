//
//  SectionViewController.swift
//  BhagavadGita
//
//  Created by Hari on 12/29/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {

    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!

    var chapter: Chapter?
    var section: Section?

    override func viewDidLoad() {
        if let s = section {
            speakerLabel.text = s.speaker
            contentLabel.text = s.content
            meaningLabel.text = s.meaning

            self.title = s.slokaNumber

            var shareButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareSection")
            self.navigationItem.rightBarButtonItem = shareButton
        }
    }

    func shareSection() {
        let subject: String = "\(Book.load().bookTitle) - \(chapter!.title) - \(section!.slokaNumber)"
        let items: [AnyObject] = [subject, SharingHelper.getSharingUrlFor(chapter: chapter!, section: section!)]
        let uaController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        uaController.setValue(subject, forKey: "subject")
        if let popoverPresentationController = uaController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            //popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection.Up
            popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem
        }
        self.presentViewController(uaController, animated: true, completion: nil)
    }
    
}
