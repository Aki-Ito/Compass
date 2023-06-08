//
//  SCBackgroundView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/22.
//

import SwiftUI

struct SCBackgroundView: View {
    var body: some View {
        ZStack {
            //MARK: backgroundView
            LinearGradient(colors: [Color( "BG1"),Color("BG2")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geometryProxy in
                let size = geometryProxy.size
                
                Color.white.opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Gradient(colors: [Color("CirclePink2"),Color("CirclePink1")]))
                    .blur(radius: 20)
                    .frame(width: 300, height: 300)
                    .offset(x: 240,y: -10)
                
                Circle()
                    .fill(Gradient(colors: [Color("CirclePink3"),Color("CirclePink4")]))
                    .blur(radius: 20)
                    .frame(width: 300, height: 300)
                    .offset(x: -170,y: 240)
            }
        }
    }
}

struct SCBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        SCBackgroundView()
    }
}
