//
//  TemperatureView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct Needle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height/2))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

struct TemperatureView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let maxValue: Int
    var value: Double = 0
    
    private let gradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))]),
                                          startPoint: .bottomLeading,
                                          endPoint: .bottomTrailing)
    
    var body: some View {
        
        ZStack {
            
            VStack {

                Spacer()
                
                Text("\(self.value, specifier: "%0.0f")˚C")
                    .font(.headline)
                    .shadow(color: colorScheme == .dark ? Color.black : Color.clear, radius: 1, x: 0, y: 0)
                    .id(value)
                    .transition(.identity)
            }
            
            Circle()
                .trim(from: 0.3, to: 1)
                .stroke(self.gradient, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 35))
                .offset(y: 10)
                .shadow(color: colorScheme == .dark ? Color.clear : Color.black.opacity(0.2), radius: 1, x: 0, y: 0)
            
            ZStack {

                Needle()
                    .fill(Color.white)
                    .frame(width: 75, height: 4)
                    .offset(x: -25)
                    .rotationEffect(.init(degrees: self.getAngle(value: self.value)), anchor: .center)
                    .animation(.easeOut)
                    .shadow(color: colorScheme == .dark ? Color.black : Color.black.opacity(0.3), radius: 1, x: 0, y: 0)
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
                    .shadow(color: colorScheme == .dark ? Color.black.opacity(0.5) : Color.clear, radius: 4, x: 0, y: 0)
            }
            .frame(alignment: .center)
            .offset(y: 10)
        }
        .frame(alignment: .center)
    }
    
    private func getAngle(value: Double) -> Double {
        let coveredRadius: Double = 215
        return (value/Double(maxValue))*coveredRadius - coveredRadius/2 + 90
    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(maxValue: 100, value: 27)
    }
}
