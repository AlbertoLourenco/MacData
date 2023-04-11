//
//  SharedData.swift
//  MacData
//
//  Created by Alberto Lourenço on 22/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Foundation

class SharedData: ObservableObject {
    
    static let shared = SharedData()
    
    @Published var data: MacData = MacData()
    
    // Settings
    
    @Published var selectedBackgroundColorID: Int = Preferences.BackgroundColorID
    
    @Published var timerOpened: Int = Util.timerDuration(by: Preferences.IndexTimerOpened)
    @Published var timerMinimized: Int = Util.timerDuration(by: Preferences.IndexTimerMinimized)
    
    @Published var statusCPU: Bool = Preferences.StatusCPU
    @Published var statusGPU: Bool = Preferences.StatusGPU
    @Published var statusRAM: Bool = Preferences.StatusRAM
    @Published var statusFAN: Bool = Preferences.StatusFAN
}
