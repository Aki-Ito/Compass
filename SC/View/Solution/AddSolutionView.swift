//
//  AddSolutionView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/23.
//

import SwiftUI

struct AddSolutionView: View {
    //MARK: CHECK INDEX
    var addSCViewModel = AddSCViewModel()
    var fetchSCViewModel = FetchSCViewModel()
    let screenSizeWidth = UIScreen.main.bounds.width
    @State private var showingAlert = false
    @State var problemText: String
    @State var solutionText: String
    @State var stepperValue: Int
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("BG2")
                    .ignoresSafeArea()
                VStack{
                    problemView()
                    attachmentView()
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("save") {
                            self.showingAlert = true
                        }
                        .foregroundColor(Color("CirclePink1"))
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Save?"),dismissButton: .default(Text("OK"),action: {
                                //MARK: access viewModel
                                Task{
                                    do{
                                       try await addSCViewModel.addSolution(problem:problemText,
                                                                    solution:solutionText,
                                                                    createAt:Date(),
                                                                    importance:stepperValue)
                                    }catch{
                                        throw error
                                    }
                                }
                            }))
                        }
                    }
                }
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
                .scrollContentBackground(Visibility.hidden)
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
                .scrollContentBackground(Visibility.hidden)
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
                Text("Importance")
                    .font(.title2)
                Spacer()
                Stepper(value: $stepperValue, in: 0...10){
                    Text("\(stepperValue)")
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                }
            }.padding()
            
                
//            ScrollView(.horizontal, showsIndicators: false){
//                HStack{
//                    ForEach((1...10),id: \.self) { data in
//                        RoundedRectangle(cornerRadius: 2)
//                            .frame(width: 100,height: 100)
//                            .foregroundColor(Color("CirclePink1"))
//                            .aspectRatio(contentMode: .fit)
//                            .cornerRadius(10)
//                    }
//                }.padding(.leading)
//            }
        }
    }
}

struct AddSolutionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSolutionView(problemText: "", solutionText: "", stepperValue: 3)
    }
}
