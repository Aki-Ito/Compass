//
//  SCListView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/11.
//

import SwiftUI

struct SCListView: View {
    
    @State var columns = [GridItem(.fixed(UIScreen.main.bounds.width - 40))]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.red).edgesIgnoringSafeArea(.bottom)
                //MARK: ListView
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach((1...50), id: \.self) { num in
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .frame(height: 100)
                                    .opacity(0.1)
                                    .background(
                                        Color.white.opacity(0.08)
                                            .blur(radius: 10)
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(
                                                
                                            )
                                            .padding(2)
                                    )
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)

                                Text("\(num)")
                                    .padding()
                            }
                        }
                    }
                }
            }.navigationBarTitle("List")
        }
    }
}

struct SCListView_Previews: PreviewProvider {
    static var previews: some View {
        SCListView()
    }
}
