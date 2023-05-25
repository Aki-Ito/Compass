//
//  SCListView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/11.
//

import SwiftUI
import Combine
import FirebaseFirestore

struct SCListView: View {
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    @State var columns = [GridItem(.fixed(UIScreen.main.bounds.width - 40))]
    
    @State private var isShowingAddView: Bool = false
    
    @StateObject var viewModel = FetchSCViewModel()
    
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
                
                //MARK: ListView
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.solutions) { solution in
                            ZStack {
                                //MARK: backGroundView
                                listBackgroundView(problem: solution.problem, solution: solution.solution, stepperValue: solution.importance)
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(solution.problem)
                                            .font(.title2)
                                            .frame(height: 20, alignment: .leading)
                                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                                        Text(solution.solution)
                                            .frame(height: 20, alignment: .leading)
                                            .padding(EdgeInsets(top: 2, leading: 30, bottom: 0, trailing: 0))
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingAddView.toggle()
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(Color("CirclePink1"))
                        }
                        .sheet(isPresented:$isShowingAddView, onDismiss: {
                            //MARK: fetch data
                            Task{
                                try await viewModel.fetchSolutions()
                            }
                        }) {
                            AddSolutionView(problemText: "", solutionText: "", stepperValue: 0)
                                .presentationDetents([.height(screenHeight*0.7)])
                        }
                    }
                }
                .onAppear{
            //MARK: fetch data
            Task{
                try await viewModel.fetchSolutions()
            }
        }
    }
    
    @ViewBuilder
    func listBackgroundView(problem: String, solution: String, stepperValue: Int) -> some View {
        NavigationLink(destination: AddSolutionView(problemText: problem, solutionText: solution, stepperValue: stepperValue)){
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
                            .linearGradient(.init(colors: [
                                Color("CirclePink1"),
                                Color("CirclePink1").opacity(0.5),
                                .clear,
                                .clear,
                                Color("CirclePink2"),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            ,lineWidth: 2.5
                        )
                        .padding(2)
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }.tint(Color("CirclePink1"))
    }
}

struct SCListView_Previews: PreviewProvider {
    static var previews: some View {
        SCListView()
    }
}
