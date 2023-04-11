//
//  SettingsView.swift
//  MacData
//
//  Created by Alberto Lourenço on 23/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedIndexTimerOpened = Preferences.IndexTimerOpened
    @State private var selectedIndexTimerMinimized = Preferences.IndexTimerMinimized
    
    @State private var selectedStatusCPU: Bool = Preferences.StatusCPU
    @State private var selectedStatusGPU: Bool = Preferences.StatusGPU
    @State private var selectedStatusRAM: Bool = Preferences.StatusRAM
    @State private var selectedStatusFAN: Bool = Preferences.StatusFAN
    
    @State private var preview: PreviewMode = Preferences.SelectViewType
    
    var body: some View {
        
        VStack (spacing: 20) {
            
            //-----------------------
            //  Header
            //-----------------------
            
            HeaderView(title: "Settings", currentScreen: .settings)
            
            //-----------------------
            //  Previews
            //-----------------------
            
            HStack (spacing: 20) {
                
                VStack {
                    
                    Image("Preview-Grid-Complex")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: preview == .gridComplex ? 115 : 90)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 3)
                                    .opacity(preview == .gridComplex ? 1 : 0))
                        .shadow(color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 0)
                        .onTapGesture {
                            self.preview = .gridComplex
                            Preferences.SelectViewType = .gridComplex
                        }
                    
                    Text("Grid (complex)")
                }
                
                VStack {
                    
                    Image("Preview-Grid-Simple")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: preview == .gridSimple ? 115 : 90)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 3)
                                    .opacity(preview == .gridSimple ? 1 : 0))
                        .shadow(color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 0)
                        .onTapGesture {
                            self.preview = .gridSimple
                            Preferences.SelectViewType = .gridSimple
                        }
                    
                    Text("Grid (simple)")
                }
                
                VStack {
                    
                    Image("Preview-List-Simple")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: preview == .listSimple ? 115 : 90)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 3)
                                    .opacity(preview == .listSimple ? 1 : 0))
                        .shadow(color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 0)
                        .onTapGesture {
                            self.preview = .listSimple
                            Preferences.SelectViewType = .listSimple
                        }
                    
                    Text("List (simple)")
                }
            }
            .frame(height: 150)
            .animation(.easeOut(duration: 0.2))
            
            //-----------------------
            //  Grid Simple - colors
            //-----------------------
            
            HStack {
                
                Text("Accent color:")
                    .frame(width: 260, alignment: .trailing)
                
                HStack {
                    ColorRadioButton(id: 0, backgroundColor: Util.colorsBackground(id: 0), selectedColor: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                    ColorRadioButton(id: 1, backgroundColor: Util.colorsBackground(id: 1), selectedColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    ColorRadioButton(id: 2, backgroundColor: Util.colorsBackground(id: 2), selectedColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    ColorRadioButton(id: 3, backgroundColor: Util.colorsBackground(id: 3), selectedColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    ColorRadioButton(id: 4, backgroundColor: Util.colorsBackground(id: 4), selectedColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    ColorRadioButton(id: 5, backgroundColor: Util.colorsBackground(id: 5), selectedColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                }
                .opacity((preview == .gridSimple) ? 1 : 0.4)
            }
            .disabled(preview != .gridSimple)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            //-----------------------
            //  Timers
            //-----------------------
            
            Group {
                
                HStack {
                    Text("Refresh interval")
                        .font(.headline)
                        .frame(width: 210, alignment: .trailing)
                        .padding(.leading, 50)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Opened:")
                        .frame(width: 260, alignment: .trailing)
                    
                    Picker("", selection: $selectedIndexTimerOpened) {
                        ForEach(0 ..< Util.timers.count, id: \.self) { count in
                            Text(" \(Util.timerDuration(by: count))s").tag(count)
                        }
                    }
                    .onReceive([self.selectedIndexTimerOpened].publisher.first(), perform: { index in
                        Preferences.IndexTimerOpened = index
                        SharedData.shared.timerOpened = Util.timerDuration(by: index)
                    })
                    .pickerStyle(RadioGroupPickerStyle())
                    .horizontalRadioGroupLayout()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Minimized:")
                        .frame(width: 260, alignment: .trailing)
                    
                    Picker("", selection: $selectedIndexTimerMinimized) {
                        ForEach(0 ..< Util.timers.count, id: \.self) { count in
                            Text(" \(Util.timerDuration(by: count))s").tag(count)
                        }
                    }
                    .onReceive([self.selectedIndexTimerMinimized].publisher.first(), perform: { index in
                        Preferences.IndexTimerMinimized = index
                        SharedData.shared.timerMinimized = Util.timerDuration(by: index)
                    })
                    .pickerStyle(RadioGroupPickerStyle())
                    .horizontalRadioGroupLayout()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
            }
            
            //-----------------------
            //  Status bar
            //-----------------------
            
            Group {
                
                HStack {
                    Text("Status bar")
                        .font(.headline)
                        .frame(width: 210, alignment: .trailing)
                        .padding(.leading, 50)
                    
                    Spacer()
                }
                
                HStack {
                    
                    VStack {

                        Text("Check items you want to see on your status bar:")
                            .frame(width: 150, alignment: .trailing)
                        
                        Spacer()
                    }
                    .frame(width: 260, alignment: .trailing)
                    
                    VStack {
                        
                        Toggle(isOn: $selectedStatusCPU) {
                            Text("CPU (temperature)")
                                .frame(width: 130, alignment: .leading)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .onReceive([self.selectedStatusCPU].publisher.first(), perform: { value in
                            Preferences.StatusCPU = value
                            SharedData.shared.statusCPU = value
                        })
                        
                        Toggle(isOn: $selectedStatusGPU) {
                            Text("GPU (temperature)")
                                .frame(width: 130, alignment: .leading)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .onReceive([self.selectedStatusGPU].publisher.first(), perform: { value in
                            Preferences.StatusGPU = value
                            SharedData.shared.statusGPU = value
                        })
                        
                        Toggle(isOn: $selectedStatusRAM) {
                            Text("RAM (free)")
                                .frame(width: 130, alignment: .leading)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .onReceive([self.selectedStatusRAM].publisher.first(), perform: { value in
                            Preferences.StatusRAM = value
                            SharedData.shared.statusRAM = value
                        })
                        
                        Toggle(isOn: $selectedStatusFAN) {
                            Text("FAN (RPM)")
                                .frame(width: 130, alignment: .leading)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .onReceive([self.selectedStatusFAN].publisher.first(), perform: { value in
                            Preferences.StatusFAN = value
                            SharedData.shared.statusFAN = value
                        })
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
        }
    }
}

fileprivate struct ColorRadioButton: View {
    
    var id: Int!
    var backgroundColor: Color!
    var selectedColor: Color!
    
    @ObservedObject private var sharedData = SharedData.shared
    
    var body: some View{
        
        ZStack (alignment: .center) {
            
            Circle()
                .frame(width: 16, height: 16)
                .foregroundColor(backgroundColor)
            
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(selectedColor)
                .opacity(sharedData.selectedBackgroundColorID == id ? 1 : 0)
                .animation(.easeOut)
        }
        .onTapGesture {
            Preferences.BackgroundColorID = id
            SharedData.shared.selectedBackgroundColorID = id
        }
    }
}

fileprivate struct TimerRadioButton: View {
    
    var index: Int!
    
    @State var selected: Bool = false
    
    var didSelect: (_ index: Int) -> Void
    
    @ObservedObject private var sharedData = SharedData.shared
    
    var body: some View{
        
        HStack (spacing: 10) {
            ZStack (alignment: .center) {
                
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.blue)
                
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(Color.white)
                    .opacity(selected ? 1 : 0)
                    .animation(.easeOut)
            }
            
            Text("\(index)s")
        }
        .onTapGesture {
            self.selected = true
            self.didSelect(self.index)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
