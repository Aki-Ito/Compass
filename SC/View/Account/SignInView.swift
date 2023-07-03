//
//  SignInView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/27.
//

import SwiftUI

struct SignInView: View {
    let characters: Array<String.Element> = Array("Compás")
    @State var opacity = 0.0
    @State var blurValue: Double = 10
    @ObservedObject private var signInWithAppleObject = SignInWithAppleRepository()
    
    var body: some View {
        ZStack {
            SCBackgroundView()
            VStack {
                Spacer()
                HStack(spacing: 1){
                    ForEach(0..<characters.count,id: \.self) { num in
                        Text(String(self.characters[num]))
                            .font(.custom("HiraMinProN-W3", fixedSize: 40))
                            .blur(radius: blurValue)
                            .opacity(opacity)
                            .animation(.easeInOut.delay( Double(num) * 0.15 ), value: blurValue)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    signInWithAppleObject.signInWithApple()
                }, label: {
                    SignInWithAppleButton()
                        .frame(height: 50)
                        .cornerRadius(16)
                })
                .fullScreenCover(isPresented: $signInWithAppleObject.isShow) {
                    TabBarView()
                }
                .padding(EdgeInsets(top: 20, leading: 40, bottom: 60, trailing: 40))
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                if blurValue == 0{
                    blurValue = 10
                    opacity = 0.01
                } else {
                    blurValue = 0
                    opacity = 1
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
