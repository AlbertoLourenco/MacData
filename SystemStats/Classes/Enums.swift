//
//  Enums.swift
//  MacData
//
//  Created by Alberto Lourenço on 24/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Foundation

//----------------------
//  Module: Screen
//----------------------

enum Screen: String {
    case gridSimple = "grid_simple"
    case gridComplex = "grid_complex"
    case listSimple = "list_simple"
    case settings = "settings"
}

//----------------------
//  Module: Settings
//----------------------

enum PreviewMode: String {
    case gridSimple = "grid_simple"
    case gridComplex = "grid_complex"
    case listSimple = "list_simple"
}

//----------------------
//  Module: HeaderView
//----------------------

enum HeaderViewOrientation {
    case vertical
    case horizontal
}
