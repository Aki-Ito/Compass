//
//  CompassionCalendarView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/05.
//

import SwiftUI

struct CompassionCalendarView: View {
    @StateObject private var viewModel: CalendarViewModel = .init()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State var allFetchedData: [CalendarModel] = []
    
    var body: some View {
        NavigationStack{
            ZStack {
                SCBackgroundView()
                    .ignoresSafeArea()
                GeometryReader{geometry in
                    VStack {
                        HStack{
                            Text("select date and do self compassion")
                                .frame(alignment: .leading)
                                .foregroundColor(.gray)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 0))
                            Spacer()
                        }
                        .frame(width: geometry.size.width,height: geometry.size.height/9)
                        .padding(.bottom)
                        CalendarView(didSelectDateSubject: viewModel.didSelectDateSubject, judgeShowingAddViewSubject: viewModel.isShowingAddView, allData: allFetchedData)
                            .frame(width: geometry.size.width, height: geometry.size.height/9*7)
                            .padding(.bottom)
                    }
                }
            }
            .navigationTitle("Calendar")
            .sheet(isPresented: $viewModel.isShowing) {
                AddCompassionView(dateComponents: viewModel.dateComponents!)
                    .presentationDetents([.height(screenHeight*0.8)])
            }
        }.onAppear{
            Task{
                do{
                    allFetchedData = try await viewModel.fetchAllDiary()
//                    try await viewModel.makeDateComponentsArray()
                }catch{
                    throw error
                }
            }
        }
    }
}

struct CompassionCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CompassionCalendarView()
    }
}
