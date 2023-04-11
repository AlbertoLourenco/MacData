//
//  ContentView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 12/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct ContentView: View, MacDataDelegate {
    
//    @ObservedObject private var sharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View {
        
        ZStack {
            
            switch coordinator.screen {
            
                //-------------
                //  MacData
                //-------------
                case .listSimple, .gridSimple, .gridComplex:
                    switch Preferences.SelectViewType {
                        case .listSimple:
                            SimpleListView()
                        case .gridSimple:
                            SimpleGridView()
                        case .gridComplex:
                            ComplexGridView()
                    }
                    
                //-------------
                //  Settings
                //-------------
                case .settings:
                    SettingsView()
            }
            
            VStack {
                
                Spacer()
                
                Text(Util.appVersion())
                    .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                    .opacity(0.6)
                    .background(coordinator.screen == .listSimple ? Color.black.opacity(0.3) : Color.clear)
            }
        }
        .frame(width: coordinator.screen == .listSimple ? 350 : 680,
               height: coordinator.screen == .listSimple ? 1030 : 630)
        .onAppear {
            MacData.shared.delegates.append(self)
            MacData.shared.startMonitor()
        }
    }
    
    //------------------------------------------------
    //  MacData Delegate
    //------------------------------------------------
    
    func macDataLoaded(data: MacData) {
        
        MacData.shared.timerDuration = TimeInterval(Util.timerDuration(by: Preferences.IndexTimerOpened))
        
        SharedData.shared.data = data
        
        self.updateStatusBar()
        
        if ScreenCoordinator.shared.dataLoaded == false {
            ScreenCoordinator.shared.dataLoaded = true
        }
    }
    
    private func updateStatusBar() {
        
        if let button = (NSApplication.shared.delegate as? AppDelegate)?.statusBarItem?.button {
            
            var title = ""
            
            if SharedData.shared.statusCPU {
                title += " CPU: \(SharedData.shared.data.cpu.die)˚C"
            }
            
            if SharedData.shared.statusGPU {
                title += " GPU: \(SharedData.shared.data.gpu.proximity)˚C"
            }
            
            if SharedData.shared.statusRAM {
                title += " RAM (\(Constants.Strings.Free.lowercased()): \(SharedData.shared.data.memory.free)) "
            }
            
            if SharedData.shared.statusFAN {
                if SharedData.shared.data.fans.count > 0 {
                    for (index, fan) in SharedData.shared.data.fans.enumerated() {
                        title += " FAN \(index + 1): \(fan.currentRPM)RPM"
                    }
                }
            }
            
            button.title = title
            button.imagePosition = .imageLeft
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
