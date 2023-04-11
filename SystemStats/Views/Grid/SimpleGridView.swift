//
//  SimpleGridView.swift
//  MacData
//
//  Created by Alberto Lourenço on 24/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct SimpleGridView: View {
    
    @ObservedObject private var sharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View {
        
        VStack (spacing: 0) {
            
            if coordinator.showUI {
                
                HeaderView(currentScreen: .gridSimple)
                
                ZStack {
                    
                    VStack (spacing: 20) {

                        HStack (spacing: 20) {
                            CardView(view: CardSystem(), simple: true)
                            CardView(view: CardFan(), simple: true)
                        }
                        .frame(width: 650, height: 150)

                        HStack (spacing: 20) {
                            CardView(view: CardCPU(), simple: true)
                            CardView(view: CardGPU(), simple: true)
                        }
                        .frame(width: 650, height: 150)

                        HStack (spacing: 20) {
                            CardView(view: CardMemory(), simple: true)
                            CardView(view: CardBattery(), simple: true)
                        }
                        .frame(width: 650, height: 150)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(Util.colorsBackground(id: Preferences.BackgroundColorID))
                .clipped()
            }else{
                EmptyView()
            }
        }
    }
}

struct SimpleGridView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleGridView()
    }
}
