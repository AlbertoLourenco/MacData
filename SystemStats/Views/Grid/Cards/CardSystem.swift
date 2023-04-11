//
//  CardSystem.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct CardSystem: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject private var sharedData: SharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View {
        
        HStack (spacing: 10) {

            VStack (alignment: .leading, spacing: 10) {

                HStack  {
                    Text("System")
                        .font(.headline)
                        .padding(5)
                        .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.2))
                        .cornerRadius(5)
                    
                    Text("")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .trailing)
                        .padding(.horizontal, 30)
                        .foregroundColor(Color.black.opacity(0.4))
                }
                .frame(maxWidth: .infinity)
                
                VStack (alignment: .leading) {
                    Spacer()
                    Text("Model: \(sharedData.data.system.model)")
                    Spacer()
                    Text("Up time: \(sharedData.data.system.uptime)")
                        .id(sharedData.data.system.uptime)
                        .transition(.identity)
                }
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 25)
        }
        .padding(.vertical, 25)
        .offset(x: coordinator.dataLoaded ? 0 : -10)
        .opacity(coordinator.dataLoaded ? 1 : 0)
        .animation(.easeOut)
    }
}

struct CardSystem_Previews: PreviewProvider {
    static var previews: some View {
        CardSystem()
    }
}
