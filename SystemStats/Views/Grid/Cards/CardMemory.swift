//
//  CardMemory.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct CardMemory: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject private var sharedData: SharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View{
        
        HStack (spacing: 10) {

            VStack (alignment: .leading, spacing: 10) {

                HStack  {
                    Text("Memory")
                        .font(.headline)
                        .padding(5)
                        .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.2))
                        .cornerRadius(5)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                VStack (alignment: .leading) {
                    Text("Free: \(sharedData.data.memory.free)")
                    Text("Busy: \(Util.handleRAMBusy(total: sharedData.data.memory.totalSize, free: sharedData.data.memory.free))")
                    Text("Total: \(sharedData.data.memory.totalSize)")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 25)
            
            ProgressCircleView(total: Util.handleRAM(total: sharedData.data.memory.totalSize),
                               label: "total",
                               progress: Util.handleRAMFree(total: sharedData.data.memory.totalSize, free: sharedData.data.memory.free),
                               indicator: "GB",
                               colorFilled: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))])
                .frame(width: 100, height: 100)
        }
        .padding(.trailing, 25)
        .offset(x: coordinator.dataLoaded ? 0 : -10)
        .opacity(coordinator.dataLoaded ? 1 : 0)
        .animation(.easeOut)
    }
}

struct CardMemory_Previews: PreviewProvider {
    static var previews: some View {
        CardMemory()
    }
}
