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
    var body: some View {
        NavigationStack{
            ZStack {
                SCBackgroundView()
                    .ignoresSafeArea()
                VStack {
                    HStack{
                        Text("select date and do self compassion")
                            .frame(alignment: .leading)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                    CalendarView(didSelectDateSubject: viewModel.didSelectDateSubject, judgeShowingAddViewSubject: viewModel.isShowingAddView)
                }
            }
            .navigationTitle("Calendar")
            .sheet(isPresented: $viewModel.isShowing) {
                AddCompassionView()
                    .presentationDetents([.height(screenHeight*0.9)])
            }
        }
    }
}

struct CompassionCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CompassionCalendarView()
    }
}
