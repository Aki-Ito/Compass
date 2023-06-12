//
//  SignInView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/27.
//

import SwiftUI

struct SignInView: View {
     @ObservedObject private var signInWithAppleObject = SignInWithAppleRepository()

     var body: some View {
         ZStack {
             SCBackgroundView()
             VStack {
                 Spacer()
                 
                 Image("aicon")
                     .opacity(0.7)
                 
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
     }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
