//
//  CardFan.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct CardFan: View {
    
    @State var showing: Bool = false
    
    var body: some View {
        
        HStack {
            
            if !showing {
                EmptyView()
            }else{
                
                FanItemView(index: 0)
                
                if Preferences.NumberOfFans > 1 {
                    
                    Divider()
                        .frame(height: 100)
                    
                    FanItemView(index: 1)
                }
            }
        }
        .frame(width: 300, height: 150)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showing = true
            }
        }
    }
}

struct FanItemView: View, MacDataDelegate {
    
    @Environment(\.colorScheme) var colorScheme
    
    var index: Int = 0
    
    @State private var data: MacFan?
    @State private var speed: CGFloat = 1
    @State private var percentage: Float = 0
    @State private var spining = false
    
    @ObservedObject private var observed: SharedData = SharedData.shared
    
    var body: some View {

        VStack (spacing: 10) {
            
            Image("Fan")
                .resizable()
                .frame(width: 40, height: 40)
                .rotationEffect(Angle(degrees: self.spining ? 360 : 0))
                .animation(Animation.linear(duration: 0.8)
                                    .repeatForever(autoreverses: false))
                .onAppear { self.spining = true }
            
            VStack (spacing: 8) {

                Text("FAN: \((data?.identifier ?? 0) + 1)")
                    .padding(5)
                    .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.2))
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity, alignment: .center)

                Text("RPM: \(data?.currentRPM ?? 0)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .id("\(index)-\(data?.currentRPM ?? 0)")
                    .transition(.identity)

                ProgressBarView(progress: self.percentage,
                                colorFilled: Util.colorsFan(value: self.percentage))
                    .frame(maxHeight: 5)
                    .padding(.horizontal, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
        .opacity(ScreenCoordinator.shared.dataLoaded ? 1 : 0)
        .animation(.easeOut)
        .onAppear(perform: {
            MacData.shared.delegates.append(self)
        })
    }
    
    //------------------------------------------------
    //  MacData Delegate
    //------------------------------------------------
    
    func macDataLoaded(data: MacData) {
        
        if index < observed.data.fans.count {
            
            self.data = observed.data.fans[index]
            
            self.percentage = Util.handleFANPercentage(current: self.data?.currentRPM ?? 0,
                                                       maximum: self.data?.maximumRPM ?? 0)
            
            self.speed = CGFloat(Util.handleFANVelocityPercentage(current: self.data?.currentRPM ?? 0,
                                                                  maximum: self.data?.maximumRPM ?? 0))
        }
    }
}

struct CardFan_Previews: PreviewProvider {
    static var previews: some View {
        CardFan()
    }
}
