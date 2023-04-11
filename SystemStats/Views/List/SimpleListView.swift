//
//  SimpleListView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 13/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct SimpleListView: View {
    
    @ObservedObject private var sharedData = SharedData.shared
    @ObservedObject private var coordinator = ScreenCoordinator.shared
    
    var body: some View {

        VStack {
            
            if coordinator.dataLoaded == false {
                
                Text(Constants.Strings.Loading)
                
            }else{
                
                HeaderView(currentScreen: .listSimple, orientation: .vertical)
                
                ScrollView (.vertical, showsIndicators: true) {

                    VStack {

                        VStack (spacing: 20) {
                            
                            Group {
                                
                                //--------------------
                                //  System
                                //--------------------
                                
                                VStack (spacing: 10) {

                                    Text(Constants.Strings.System)
                                        .font(.headline)
                                    
                                    VStack {
                                        Text("\(Constants.Strings.Model): \(sharedData.data.system.model)")
                                        Text("\(Constants.Strings.UpTime): \(sharedData.data.system.uptime)")
                                    }
                                }
                                
                                Divider()
                                
                                //--------------------
                                //  CPU
                                //--------------------
                                
                                VStack (spacing: 10) {

                                    Text(Constants.Strings.CPU)
                                        .font(.headline)
                                    
                                    VStack {
                                        Text("Logical (cores): \(sharedData.data.cpu.amountLogical)")
                                        Text("Physical (cores): \(sharedData.data.cpu.amountPhysical)")
                                        Text("Threads: \(sharedData.data.cpu.threads)")
                                        Text("Processes: \(sharedData.data.cpu.processes)")
                                        Text("Temperature: \(NSString(format:"%.1f", sharedData.data.cpu.proximity) as String)˚C")
                                    }
                                }
                                
                                Divider()
                                
                                //--------------------
                                //  Fans
                                //--------------------
                                
                                if sharedData.data.fans.count > 0 {

                                    VStack (spacing: 10) {

                                        Text("Fan")
                                            .font(.headline)
                                        
                                        ForEach(sharedData.data.fans, id: \.self) { item in
                                         
                                            VStack {

                                                Text("Fan: \(item.identifier)")
                                                    .font(.subheadline)
                                                
                                                VStack {
                                                    Text("Current RPM: \(item.currentRPM)")
                                                    Text("Minimum RPM: \(item.minimumRPM)")
                                                    Text("Maximum RPM: \(item.maximumRPM)")
                                                }
                                            }
                                        }
                                    }
                                    
                                    Divider()
                                }
                            }
                            
                            Group {
                                
                                //--------------------
                                //  GPU
                                //--------------------
                                
                                VStack (spacing: 10) {

                                    Text(Constants.Strings.GPU)
                                        .font(.headline)
                                    
                                    VStack {
                                        Text("PECI: \(NSString(format:"%.1f", sharedData.data.gpu.peci) as String)")
                                        Text("Diode: \(NSString(format:"%.1f", sharedData.data.gpu.diode) as String)")
                                        Text("Heatsink: \(NSString(format:"%.1f", sharedData.data.gpu.heatsink) as String)")
                                        Text("Temperature: \(NSString(format:"%.1f", sharedData.data.gpu.proximity) as String)˚C")
                                    }
                                }
                                
                                Divider()
                                
                                //--------------------
                                //  Memory
                                //--------------------
                                
                                VStack (spacing: 10) {

                                    Text(Constants.Strings.Memory)
                                        .font(.headline)
                                    
                                    VStack {
                                        Text("Size: \(sharedData.data.memory.totalSize)")
                                        Text("Free: \(sharedData.data.memory.free)")
                                        Text("Wired: \(sharedData.data.memory.wired)")
                                        Text("Active: \(sharedData.data.memory.active)")
                                        Text("Inactive: \(sharedData.data.memory.inactive)")
                                        Text("Compressed: \(sharedData.data.memory.compressed)")
                                    }
                                }
                                
                                Divider()
                                
                                //--------------------
                                //  Battery
                                //--------------------
                                
                                VStack (spacing: 10) {

                                    Text(Constants.Strings.Battery)
                                        .font(.headline)
                                    
                                    VStack {
                                        Text("Cycles: \(sharedData.data.battery.cycles)")
                                        Text("Health: \(sharedData.data.battery.charge)")
                                        Text("Charged: \((sharedData.data.battery.charged) ? "YES" : "NO")")
                                        Text("Charging: \((sharedData.data.battery.charging) ? "YES" : "NO")")
                                    }
                                }
                                
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SimpleListView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleListView()
    }
}
