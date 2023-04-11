//
//  ComplexGridView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 13/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct ComplexGridView: View {
    
    @ObservedObject private var sharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View {
        
        VStack (spacing: 0) {
            
            if coordinator.showUI {
                
                HeaderView(currentScreen: .gridComplex)
                
                ZStack {
                    
                    ZStack {
                        BackgroundView(size: 700, colorsStart: [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)], colorsEnd: [#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)])
                            .offset(x: -250, y: 50)
                        
                        BackgroundView(size: 900, colorsStart: [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)], colorsEnd: [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)])
                                .offset(x: 300, y: 0)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))]),
                                               startPoint: .bottomLeading,
                                               endPoint: .topTrailing))
                    .clipped()
                    
                    VStack (spacing: 20) {

                        HStack (spacing: 20) {
                            CardView(view: CardSystem())
                            CardView(view: CardFan())
                        }
                        .frame(width: 650, height: 150)

                        HStack (spacing: 20) {
                            CardView(view: CardCPU())
                            CardView(view: CardGPU())
                        }
                        .frame(width: 650, height: 150)

                        HStack (spacing: 20) {
                            CardView(view: CardMemory())
                            CardView(view: CardBattery())
                        }
                        .frame(width: 650, height: 150)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    .background(Color.clear)
                    .animation(.easeInOut)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            }else{
                EmptyView()
            }
        }
    }
}

struct ComplexGridView_Previews: PreviewProvider {
    static var previews: some View {
        ComplexGridView()
    }
}
