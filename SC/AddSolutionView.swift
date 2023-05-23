//
//  AddSolutionView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/23.
//

import SwiftUI

struct AddSolutionView: View {
    
    let screenSizeWidth = UIScreen.main.bounds.width
    @State var problemText: String = "write the problem"
    @State var solutionText: String = "write the solution"
    
    var body: some View {
        ZStack{
            Color.white.opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button("Save") {
                        print("tapped")
                    }
                    .padding()
                    .foregroundColor(Color("CirclePink1"))
                }
                .frame(width: screenSizeWidth, height: 120)
                
                problemView()
                attachmentView()
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func problemView() -> some View{
        VStack{
            HStack{
                Text("Problem")
                    .font(.title2)
                Text("write the problem")
                    .foregroundColor(.gray)
                Spacer()
            }
            TextEditor(text: $problemText)
                .padding()
                .frame(height: 100)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
            
            HStack{
                Text("Solution")
                    .font(.title2)
                Text("using chatGPT")
                    .foregroundColor(.gray)
                Spacer()
            }
            
            TextEditor(text: $solutionText)
                .padding()
                .frame(height: 200)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
        }.padding()
    }
    
    @ViewBuilder
    func attachmentView() -> some View{
        VStack{
            HStack{
                Text("Attachment")
                    .font(.title2)
                Spacer()
            }.padding()
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach((1...10),id: \.self) { data in
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 100,height: 100)
                            .foregroundColor(Color("CirclePink1"))
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                }.padding(.leading)
            }
        }
    }
}

struct AddSolutionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSolutionView()
    }
}
