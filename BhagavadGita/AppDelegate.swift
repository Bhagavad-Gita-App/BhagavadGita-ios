//
//  AppDelegate.swift
//  BhagavadGita
//
//  Created by Hari on 12/9/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme != "bhagavadgitamalayalam" {
            return false
        }

        var chapterIndex:Int?
        var sectionIndex:Int?

        let parts = url.path.components(separatedBy: "/")
        switch parts.count {
        case 2:
            chapterIndex = Int(parts[1])
        case 3:
            chapterIndex = Int(parts[1])
            sectionIndex = Int(parts[2])
        default:
            return false
        }
        navigateTo(chapterIndex, sectionIndex)
        return false
    }

    func navigateTo(_ chapterIndex: Int?, _ sectionIndex: Int?) {
        if let navController = self.window?.rootViewController as? UINavigationController {
            if let storyBoard = navController.storyboard {
                if let chapterIndexUnwrapped = chapterIndex {
                    if let chapterVc = storyBoard.instantiateViewController(withIdentifier: "ChapterVC") as? ChapterViewController {
                        if let chapter = Book.getChapter(atIndex: chapterIndexUnwrapped) {
                            chapterVc.chapter = chapter
                            navController.pushViewController(chapterVc, animated: false)
                            if let sectionIndexUnwrapped = sectionIndex {
                                if let sectionVc = storyBoard.instantiateViewController(withIdentifier: "SectionVC") as? SectionViewController {
                                    if let section = Book.getSection(atChapterIndex: chapterIndexUnwrapped, atSectionIndex: sectionIndexUnwrapped) {
                                        sectionVc.chapter = chapter
                                        sectionVc.section = section
                                        navController.pushViewController(sectionVc, animated: false)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

