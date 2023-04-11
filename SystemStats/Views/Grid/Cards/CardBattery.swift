//
//  CardBattery.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct CardBattery: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject private var sharedData: SharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View {
        
        HStack (spacing: 10) {

            VStack (alignment: .leading, spacing: 10) {

                HStack  {
                    Text("Battery")
                        .font(.headline)
                        .padding(5)
                        .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.2))
                        .cornerRadius(5)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                VStack (alignment: .leading) {

                    Text("Cycles: \(sharedData.data.battery.cycles)")
                    Text("Charged: \((sharedData.data.battery.charged) ? "YES" : "NO")")
                    Text("Charging: \((sharedData.data.battery.charging) ? "YES" : "NO")")
                    Text("Temperature: \(sharedData.data.battery.temperature)")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 25)
            
            ProgressCircleView(total: Util.handleBattery(total: sharedData.data.battery.charge),
                               label: "charged",
                               progress: Util.handleBattery(total: sharedData.data.battery.charge) / 100,
                               indicator: "%%",
                               colorFilled: [Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))])
                .frame(width: 100, height: 100)
        }
        .padding(.trailing, 25)
        .offset(x: coordinator.dataLoaded ? 0 : 10)
        .opacity(coordinator.dataLoaded ? 1 : 0)
        .animation(.easeOut)
    }
}

struct CardBattery_Previews: PreviewProvider {
    static var previews: some View {
        CardBattery()
    }
}
