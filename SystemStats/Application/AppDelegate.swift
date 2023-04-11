//
//  AppDelegate.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 12/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Cocoa
import SwiftUI
import LaunchAtLogin
import UserNotifications

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    let notificationCenter = UNUserNotificationCenter.current()
    
    @ObservedObject private var sharedData = SharedData.shared
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        //-------------------------
        //  Open at login
        //-------------------------
        
        LaunchAtLogin.isEnabled = true
        
        //-------------------------
        //  Store number of FANs
        //-------------------------
        
        if Preferences.NumberOfFans == 0 {
            Preferences.NumberOfFans = MacData.shared.countFANs()
        }
        
        //-------------------------
        //  Config User Notif.
        //-------------------------
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
            if !didAllow { print("User has declined notifications") }
        }
        
        //-------------------------
        //  Status bar
        //-------------------------
        
//        self.configPopover(ContentView())
        self.configStatusBar()
        
        ScreenCoordinator.shared.screen = Screen(rawValue: Preferences.SelectViewType.rawValue) ?? .gridComplex
        ScreenCoordinator.shared.showUI = true
        
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 650, height: 600),
                          styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                          backing: .buffered,
                          defer: true)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: ContentView())
        window.makeKeyAndOrderFront(nil)
        
        //-------------------------
        //  Show automatically
        //-------------------------
        
//        #if DEBUG
//        self.togglePopover(nil)
//        #endif
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        MacData.shared.stopMonitor()
    }
    
    func applicationDidResignActive(_ notification: Notification) {
//        self.closePopover() // close popover when click outside
    }
    
    //-----------------------------------------------------------------------
    //  MARK: Custom methods
    //-----------------------------------------------------------------------
    
    func closeApp() {
        for runningApplication in NSWorkspace.shared.runningApplications {
            if runningApplication.bundleIdentifier == Bundle.main.bundleIdentifier {
                runningApplication.forceTerminate()
            }
        }
    }
    
    private func configPopover<T: View>(_ view: T) {
        
        //----------------------
        //  Config popover
        //----------------------

        let popover = NSPopover()
        popover.contentSize = NSSize(width: 650, height: 600)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: view)
        self.popover = popover
    }
    
    private func configStatusBar() {
        
        //----------------------
        //  Status item
        //----------------------

        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "MenuIcon")
            button.action = #selector(togglePopover(_:))
        }
    }
    
    @objc private func togglePopover(_ sender: AnyObject?) {
        
        NSApp.activate(ignoringOtherApps: true)
        
//        if let button = self.statusBarItem.button {
//
//            if self.popover.isShown {
//                self.closePopover()
//            }else{
//
//                MacData.shared.timerDuration = TimeInterval(Util.timerDuration(by: Preferences.IndexTimerOpened))
//
//                ScreenCoordinator.shared.screen = Screen(rawValue: Preferences.SelectViewType.rawValue) ?? .gridComplex
//                ScreenCoordinator.shared.showUI = true
//
//                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.maxY)
//                self.popover.contentViewController?.view.window?.becomeKey()
//
//                DispatchQueue.main.async {
//                    SoundPlayer.play(fileName: "start", fileExtension: "aiff")
//                }
//            }
//        }
        
        window.makeKeyAndOrderFront(nil)
    }
    
    private func closePopover() {
        
        self.popover.performClose(nil)
        
        ScreenCoordinator.shared.showUI = false
        
        MacData.shared.timerDuration = TimeInterval(Util.timerDuration(by: Preferences.IndexTimerMinimized))
    }
}

