//
//  BackgroundView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 19/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct BackgroundView: NSViewRepresentable {
    
    var size: CGFloat = 200
    var colorsStart: Array<CGColor> = [NSColor.blue.cgColor, NSColor.red.cgColor]
    var colorsEnd: Array<CGColor> = [NSColor.green.cgColor, NSColor.blue.cgColor]
    
    func makeNSView(context: NSViewRepresentableContext<BackgroundView>) -> NSView {
        
        let view = NSView()
        view.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        view.wantsLayer = true
        view.layer?.masksToBounds = true
        
        //  Config
        
        let frame: CGRect = CGRect(origin: CGPoint(x: 0, y: -50), size: CGSize(width: size, height: size))
        
        let config = MorphConfig(frame: frame,
                                 duration: 10,
                                 rotationEnabled: true,
                                 rotationDuration: 30,
                                 colorsStart: colorsStart,
                                 colorsEnd: colorsEnd,
                                 backgroundColor: .clear)
        
        //  Add view
        
        let organicView = OrganicView(config: config)
        organicView.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        organicView.wantsLayer = true
        organicView.layer?.masksToBounds = true
        
        view.addSubview(organicView)
        
        return view
    }
    
    func updateNSView(_ uiView: NSView, context: NSViewRepresentableContext<BackgroundView>) {}
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
