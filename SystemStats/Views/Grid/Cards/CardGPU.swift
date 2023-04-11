//
//  CardGPU.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct CardGPU: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject private var sharedData: SharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View {
        
        HStack (spacing: 10) {

            VStack (alignment: .leading, spacing: 10) {

                HStack  {
                    Text("GPU")
                        .font(.headline)
                        .padding(5)
                        .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.2))
                        .cornerRadius(5)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                VStack (alignment: .leading) {
                    Text("PECI: \(NSString(format:"%.1f", sharedData.data.gpu.peci) as String)")
                    Text("Diode: \(NSString(format:"%.1f", sharedData.data.gpu.diode) as String)")
                    Text("Heatsink: \(NSString(format:"%.1f", sharedData.data.gpu.heatsink) as String)")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 25)
            
            TemperatureView(maxValue: 90, value: Double(sharedData.data.gpu.proximity))
                .frame(width: 100, height: 100)
        }
        .padding(.trailing, 25)
        .offset(x: coordinator.dataLoaded ? 0 : 10)
        .opacity(coordinator.dataLoaded ? 1 : 0)
        .animation(.easeOut)
    }
}

struct CardGPU_Previews: PreviewProvider {
    static var previews: some View {
        CardGPU()
    }
}
