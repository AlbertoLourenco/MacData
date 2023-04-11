//
//  ProgressBarView.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 15/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    
    var progress: Float
    var colorFilled: Array<Color> = []
    
    private let colorEmpty: Color = Color.black.opacity(0.3)
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                
                Rectangle()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(self.colorEmpty)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width),
                           height: geometry.size.height)
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: self.colorFilled),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .animation(.easeOut)
            }
            .cornerRadius(3)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: 0.3,
                        colorFilled: Util.colorsFan(value: 0.5))
    }
}
