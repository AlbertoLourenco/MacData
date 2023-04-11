//
//  CardView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 20/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct CardView<T:View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var view: T
    var simple: Bool = false
    
    @State private var mouseHover: Bool = false
    
    var body: some View {
        view
            .frame(width: 300, height: 150)
//            .frame(width: self.mouseHover ? 315 : 300, height: self.mouseHover ? 165 : 150)
            .visualEffect(material: colorScheme == .dark ? .hudWindow : .popover,
                          blendingMode: .withinWindow,
                          emphasized: true)
            .cornerRadius(30, antialiased: true)
//            .onHover { (active) in
//                if !simple {
//                    self.mouseHover = active
//                }
//            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(view: EmptyView())
    }
}
