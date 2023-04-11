//
//  ScreenCoordinator.swift
//  MacData
//
//  Created by Alberto Lourenço on 21/11/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Foundation

class ScreenCoordinator: ObservableObject {
    
    static let shared = ScreenCoordinator()
    
    // Home
    
    @Published var showUI: Bool = false
    @Published var dataLoaded: Bool = false
    
    // Home and Settings
    
    @Published var screen: Screen = .gridComplex
}
