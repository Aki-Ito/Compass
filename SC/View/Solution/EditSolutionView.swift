//
//  EditSolutionView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/26.
//

import SwiftUI

struct EditSolutionView: View {
    //MARK: CHECK INDEX
    var addSCViewModel = AddSCViewModel()
    var fetchSCViewModel = FetchSCViewModel()
    let screenSizeWidth = UIScreen.main.bounds.width
    @State var problemText: String
    @State var solutionText: String
    @State var stepperValue: Int
    
    var body: some View {
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
                        }
                        .foregroundColor(Color("CirclePink1"))
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
                .frame(height: 360)
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
        }
    }
}

struct EditSolutionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSolutionView(problemText: "preview", solutionText: "preview", stepperValue: 3)
    }
}
