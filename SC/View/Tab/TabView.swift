//
//  TabView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/09.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var tabHelper: TabBarHelper
    @StateObject var calendarViewModel = CalendarViewModel()
    @State var currentTab: Tab = .solution
    @Namespace var animation
    var body: some View {
        ZStack {
            SCBackgroundView()
            TabView(selection: $currentTab) {
                FeaturedView()
                    .tag(Tab.solution)
                CompassionCalendarView()
                    .tag(Tab.compassion)
                EditAccountView()
                    .tag(Tab.account)
            }
            
            VStack {
                Spacer()
                TabBar()
            }
        }
    }
    
    //MARK: TabBar
    @ViewBuilder
    func TabBar() -> some View{
        HStack(spacing: 0){
            ForEach(Tab.allCases, id: \.rawValue){tab in
                VStack(spacing: -2) {
                    Image(systemName: tab.rawValue)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28,height: 28)
                        .foregroundColor(currentTab == tab ? Color("CirclePink1"): .gray.opacity(0.6))
                    
                    if currentTab == tab{
                        Circle()
                            .fill(Color("CirclePink1"))
                            .frame(width: 5, height: 6)
                            .offset(y: 10)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){currentTab = tab}
                    
                }
            }
        }
        //MARK: tab height
        .frame(height: 60)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(TabBarHelper())
    }
}
