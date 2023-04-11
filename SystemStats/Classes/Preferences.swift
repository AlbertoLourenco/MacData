//
//  Preferences.swift
//  MacData
//
//  Created by Alberto Lourenço on 25/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Foundation

struct Preferences {
    
    //--------------------------------------
    //  View type
    //--------------------------------------
    
    static var SelectViewType: PreviewMode {
        get { return PreviewMode(rawValue: UserDefaults.standard.string(forKey: "ViewType") ?? "") ?? .gridComplex }
        set (newValue) { UserDefaults.standard.set(newValue.rawValue, forKey: "ViewType") }
    }
    
    //--------------------------------------
    //  Number of FANs
    //--------------------------------------
    
    static var NumberOfFans: Int {
        get { return UserDefaults.standard.integer(forKey: "NumberOfFans") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "NumberOfFans") }
    }
    
    //--------------------------------------
    //  Background color
    //--------------------------------------
    
    static var BackgroundColorID: Int {
        get { return UserDefaults.standard.integer(forKey: "BackgroundColorID") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "BackgroundColorID") }
    }
    
    //--------------------------------------
    //  Timers
    //--------------------------------------
    
    static var IndexTimerOpened: Int {
        get { return UserDefaults.standard.integer(forKey: "IndexTimerOpened") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "IndexTimerOpened") }
    }
    
    static var IndexTimerMinimized: Int {
        get { return UserDefaults.standard.integer(forKey: "IndexTimerMinimized") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "IndexTimerMinimized") }
    }
    
    //--------------------------------------
    //  Status bar infos
    //--------------------------------------
    
    static var StatusCPU: Bool {
        get { return UserDefaults.standard.bool(forKey: "StatusCPU") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "StatusCPU") }
    }
    
    static var StatusGPU: Bool {
        get { return UserDefaults.standard.bool(forKey: "StatusGPU") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "StatusGPU") }
    }
    
    static var StatusRAM: Bool {
        get { return UserDefaults.standard.bool(forKey: "StatusRAM") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "StatusRAM") }
    }
    
    static var StatusFAN: Bool {
        get { return UserDefaults.standard.bool(forKey: "StatusFAN") }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: "StatusFAN") }
    }
}
