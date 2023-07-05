
//
//  EditSolutionView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/26.
//

import SwiftUI

struct EditSolutionView: View {
    var addSCViewModel = AddSCViewModel()
    var fetchSCViewModel = FetchSCViewModel()
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeHeight = UIScreen.main.bounds.height
    let barHelper = BarHelper.shared
    
    @EnvironmentObject var tabHelper: TabBarHelper
    
    @State private var showingAlert = false
    @State private var showingDeleteAlert = false
    @State var problemText: String
    @State var solutionText: String
    @State var stepperValue: Int
    
    @State var problemTextHeight: CGFloat = 0
    @State var solutionTextHeight: CGFloat = 0
    @State var stepperHeight: CGFloat = 0
    @State var problemEditTextHeight: CGFloat = 0
    @State var solutionEditTextHeight: CGFloat = 0
    
    //MARK: identify the solution(firestore documentID)
    let id: String
    
    var body: some View {
        ZStack{
            Color("BG2")
                .ignoresSafeArea()
            GeometryReader{geometry in
                VStack{
                    problemView()
                        .frame(height: geometry.size.height)
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            self.showingDeleteAlert = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(Color("CirclePink1"))
                        }
                        .alert(isPresented: $showingDeleteAlert) {
                            Alert(title: Text("delete?"),primaryButton:.cancel(Text("cancel")),secondaryButton: .destructive(Text("OK"),action: {
                                //MARK: access viewModel
                                Task{
                                    do{
                                        try await SolutionModel.deleteSolution(id: id)
                                    }catch{
                                        throw error
                                    }
                                }
                                
                            }))
                        }
                        
                    }
                    
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
                                        try await addSCViewModel.editSolution(problem: problemText, solution: solutionText, importance: stepperValue, id: id)
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
                .frame(minHeight: problemEditTextHeight)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
            
            HStack{
                Text("Solution")
                    .font(.title2)
                Text("write the solution")
                    .foregroundColor(.gray)
                Spacer()
            }
            
            TextEditor(text: $solutionText)
                .scrollContentBackground(Visibility.hidden)
                .padding()
                .frame(minHeight: solutionEditTextHeight)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
            
            HStack{
                Text("Importance")
                    .font(.title2)
                Spacer()
                Stepper(value: $stepperValue, in: 0...10){
                    Text("\(stepperValue)")
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 50, trailing: 0))
        }
        .padding()
    }
}

struct EditSolutionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSolutionView(problemText: "preview", solutionText: "preview", stepperValue: 3, id: "vvv").environmentObject(TabBarHelper())
    }
}
