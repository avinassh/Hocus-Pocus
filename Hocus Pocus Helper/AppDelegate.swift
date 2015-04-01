//
//  AppDelegate.swift
//  Hocus Pocus Helper
//
//  Created by avi on 01/04/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        println(NSBundle.mainBundle().bundlePath)
        let pathToMainApp = NSBundle.mainBundle().bundlePath.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent
        NSWorkspace.sharedWorkspace().launchApplication("Hocus Pocus.app")
        NSApplication.sharedApplication().terminate(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

