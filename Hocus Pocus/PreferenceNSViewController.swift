//
//  PreferencesViewController.swift
//  Hocus Pocus
//
//  Created by avi on 01/04/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import Cocoa

class PreferenceNSViewController: NSViewController, CCNPreferencesWindowControllerProtocol {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "PreferenceNSViewController", bundle: nil)
    }
    
    func preferenceIcon() -> NSImage! {
        return NSImage(named: NSImageNamePreferencesGeneral)
    }
    
    func preferenceTitle() -> String! {
        return "General"
    }
    
    func preferenceIdentifier() -> String! {
        return "GeneralPreferencesIdentifier"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func startAtLogin(sender: NSButton) {
        println(sender.state)
        // To Do:
        // implement code here which puts this app into Startup Login Items
    }
    
}