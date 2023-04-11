//
//  ProgressCircleView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct ProgressCircleView: View {
    
    var total: Float = 0
    var label: String = ""
    var progress: Float = 0
    var indicator: String = "%%"
    var colorFilled: Array<Color> = []
    
    private let colorEmpty: Color = Color.black.opacity(0.12)
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(self.colorEmpty)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(
                    LinearGradient(gradient: Gradient(colors: self.colorFilled),
                                   startPoint: .bottomLeading,
                                   endPoint: .topTrailing),
                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            VStack {

                Text(String(format: "%.0f\(self.indicator)", self.total))
                    .font(.headline)
                    .bold()
                    .id(self.total)
                    .transition(.identity)
                
                Text(self.label)
                    .font(.system(size: 10))
            }
            .offset(y: 3)
        }
        .background(Color.black.opacity(0.08))
        .clipShape(Circle())
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progress: 0.36,
                           indicator: "˚C",
                           colorFilled: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))])
    }
}
