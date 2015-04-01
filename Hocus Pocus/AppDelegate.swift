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
    @IBOutlet weak var showHiddenFilesMenuItem: NSMenuItem!
    
    // variable which refers to our preferences window
    var preferences : CCNPreferencesWindowController!

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
        
        // check the current status. If the hidden files are already visible, 
        // then show the checkmark
        if "YES" == getCurrentHideStatus() {
            showHiddenFilesMenuItem.state = NSOnState
        }
        
        // code for setting up preferences
        preferences = CCNPreferencesWindowController()
        preferences.centerToolbarItems = true
        preferences.setPreferencesViewControllers([PreferenceNSViewController()])
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
    
    @IBAction func exitApp(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(nil)
    }
    
    @IBAction func showAboutWindow(sender: NSMenuItem) {
        NSApplication.sharedApplication().orderFrontStandardAboutPanel(nil)
    }
    
    @IBAction func displayPreferences(sender: NSMenuItem) {
        preferences.showPreferencesWindow()
    }
    
    
    func getCurrentHideStatus() -> String {
        // createa  new pipe which holds the output of command run
        var pipe = NSPipe()
        let checkStatus = NSTask()
        // set the output of NSTask to pipe, so that output is written to pipe
        checkStatus.standardOutput = pipe
        checkStatus.launchPath = "/usr/bin/defaults"
        checkStatus.arguments = ["read", "com.apple.finder", "AppleShowAllFiles"]

        checkStatus.launch()
        checkStatus.waitUntilExit()
        
        // read the pipe data, it is actaully of NSData
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        // convert the read NSData to string
        if let output = NSString(data: data, encoding: NSUTF8StringEncoding) {
            // the returned output contains a newline character at the end 
            // and this introduced a bug. Following change will strip away the 
            // newline characters. 
            // stringByTrimmingCharactersInSet(_:) returns a new string object,
            // hence even though 'output' is a constant variable, we can call 
            // on it
            return output.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        }
        
        return "NO"
    }
    
}

