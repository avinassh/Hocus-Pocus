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
        // using NSTask we can send commands to terminal. It basically spawns
        // a sub process and runs the task
        let hideFilesTask = NSTask()
        // path to the launchpath, which has the excuteable
        hideFilesTask.launchPath = "/usr/bin/defaults"
        
        // Initially it's NSOffState, so for first time this if block will
        // result to true and will be executed
        if (sender.state == NSOffState) {
            // lets change it to NSOnState and display hidden files
            sender.state = NSOnState
            hideFilesTask.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
        }
        else {
            sender.state = NSOffState
            hideFilesTask.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "NO"]
        }
        
        // run the command
        hideFilesTask.launch()
        // wait till the tasks are completed and then restart the finder
        // to see effects
        // This is blocking code
        hideFilesTask.waitUntilExit()
        
        let killTask = NSTask()
        killTask.launchPath = "/usr/bin/killall"
        killTask.arguments = ["Finder"]
        killTask.launch()
    }
    
}

