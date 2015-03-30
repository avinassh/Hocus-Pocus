//
//  AppDelegate.swift
//  Hocus Pocus
//
//  Created by avi on 30/03/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!

    // Menu Bar is what generally called, but in code it's actually called as
    // statusBar and statusMenu
    
    // first we will create a statusItem and then we will place it on
    // statusBar
    
    // NSStatusBar.systemStatusBar() gets the main statusBar of OS
    // .statusItemWithLength returns a statusItem
    // In Objective-C, for length parameter we could send NSVariableStatusItemLength
    // but it's not ported to Swift yet, so will just send its value -1
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let icon = NSImage(named: "statusIcon")
        // Yosemite has darkmode. So following tells the OS that invert the icon
        // if it is in dark mode
        icon?.setTemplate(true)
        
        // set the icon to statusItem
        statusItem.image = icon
        // add the custom menu we created to the statusItem
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func showHiddenFiles(sender: NSMenuItem) {
        println("Hidden files will be displayed")
    }
    
}

