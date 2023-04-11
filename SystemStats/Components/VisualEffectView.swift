//
//  VisualEffectView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 13/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct VisualEffectBackground: NSViewRepresentable {
    
    private let material: NSVisualEffectView.Material
    private let blendingMode: NSVisualEffectView.BlendingMode
    private let isEmphasized: Bool
    
    init(material: NSVisualEffectView.Material, blendingMode: NSVisualEffectView.BlendingMode, emphasized: Bool) {
        self.material = material
        self.blendingMode = blendingMode
        self.isEmphasized = emphasized
    }
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        return NSVisualEffectView()
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.state = .active
        nsView.material = material
        nsView.blendingMode = blendingMode
        nsView.isEmphasized = isEmphasized
    }
}
