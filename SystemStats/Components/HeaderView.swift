//
//  HeaderView.swift
//  MacData
//
//  Created by Alberto Lourenço on 25/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var title: String = ""
    var currentScreen: Screen = .listSimple
    var orientation: HeaderViewOrientation = .horizontal
    
    var body: some View {
        
        HStack {
            
            if orientation == .horizontal {
                
                ZStack (alignment: .center) {
                    
                    if title.isEmpty {
                        Image(currentScreen == .listSimple ? Constants.Image.LogoSmall : Constants.Image.LogoLarge)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 30)
                    }else{
                        Text(title)
                            .font(.system(size: 18, weight: Font.Weight.medium, design: Font.Design.rounded))
                            .frame(width: 125, height: 30)
                    }
                    
                    HStack {
                        
                        ZStack (alignment: .bottom) {
                            
                            Text(currentScreen != .settings ? Constants.Strings.Close : Constants.Strings.Back)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                            
                            if currentScreen != .settings {
                                
                                Rectangle()
                                    .foregroundColor(Color.red)
                                    .frame(maxWidth: 55, maxHeight: 1)
                            }
                        }
                        .clipped()
                        .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.7))
                        .cornerRadius(5)
                        .onTapGesture {
                            
                            if currentScreen != .settings {
                                (NSApplication.shared.delegate as? AppDelegate)?.closeApp()
                            }else{
                                withAnimation{
                                    ScreenCoordinator.shared.screen = Screen(rawValue: Preferences.SelectViewType.rawValue) ?? .gridComplex
                                }
                            }
                        }
                        
                        if currentScreen != .settings {
                            
                            Text(Constants.Strings.Settings)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.7))
                                .cornerRadius(5)
                                .onTapGesture {
                                    ScreenCoordinator.shared.screen = .settings
                                }
                            
                            Spacer()
                            
                            Text(Constants.Strings.CleanMemory)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.7))
                                .cornerRadius(5)
                                .onTapGesture {
                                    SystemAdmin.shared.cleanMemory()
                                }
                        }else{
                            Spacer()
                        }
                    }
                }
                
            }else{
                
                VStack (alignment: .center) {
                    
                    if title.isEmpty {
                        Image(currentScreen == .listSimple ? Constants.Image.LogoSmall : Constants.Image.LogoLarge)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 30)
                    }else{
                        Text(title)
                            .font(.title)
                            .frame(width: 125, height: 30)
                    }
                    
                    HStack {
                        
                        ZStack (alignment: .bottom) {
                            
                            Text(Constants.Strings.Close)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                            
                            Rectangle()
                                .foregroundColor(Color.red)
                                .frame(maxWidth: 55, maxHeight: 1)
                        }
                        .clipped()
                        .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.7))
                        .cornerRadius(5)
                        .onTapGesture {
                            (NSApplication.shared.delegate as? AppDelegate)?.closeApp()
                        }
                        
                        if currentScreen != .settings {
                            
                            Text(Constants.Strings.Settings)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(5)
                                .onTapGesture {
                                    withAnimation{
                                        ScreenCoordinator.shared.screen = .settings
                                    }
                                }
                            
                            Spacer()
                            
                            Text(Constants.Strings.CleanMemory)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white.opacity(0.7))
                                .cornerRadius(5)
                                .onTapGesture {
                                    SystemAdmin.shared.cleanMemory()
                                }
                        }else{
                            Spacer()
                        }
                    }
                    .padding(.top, 10)
                }
            }
        }
        .padding()
        .visualEffect(material: .titlebar,
                      blendingMode: .behindWindow,
                      emphasized: true)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(currentScreen: .gridComplex)
    }
}
