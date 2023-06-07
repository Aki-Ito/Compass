//
//  CompassionCalendarView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/05.
//

import SwiftUI

struct CompassionCalendarView: View {
    @StateObject private var viewModel: CalendarViewModel = .init()
    let viewWidth = UIScreen.main.bounds.width
    let viewHeight = UIScreen.main.bounds.height
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
                    CalendarView(didSelectDateSubject: viewModel.didSelectDateSubject)
                }
            }
            .navigationTitle("Calendar")
        }
    }
}

struct CompassionCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CompassionCalendarView()
    }
}
