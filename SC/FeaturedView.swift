//
//  FeaturedView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/14.
//

import SwiftUI

struct FeaturedView: View {
    @State var currentTab: Tab = .home
    @Namespace var animation
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 15){
            HeaderView()
            SearchBar()
            
            //MARK: Custom Carousel
            Carousel(index: $currentIndex, items: movies, cardPadding: 150, id: \.id) { movie,cardSize in
                
                Image(movie.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardSize.width,height: cardSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .padding(.horizontal,-15)
            .padding(.vertical)
            
            TabBar()
        }
        .padding([.horizontal, .top],15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background{
                GeometryReader { proxy in
                    LinearGradient(colors: [Color("BG1"),Color("BG2")], startPoint: .top, endPoint: .bottom)
                }.ignoresSafeArea()
            }
    }
    
    //MARK: TabBar
    @ViewBuilder
    func TabBar() -> some View{
        HStack(spacing: 0){
            ForEach(Tab.allCases, id: \.rawValue){tab in
                VStack(spacing: -2) {
                    Image(tab.rawValue)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28,height: 28)
                        .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.6))
                    
                    if currentTab == tab{
                        Circle()
                            .fill(.white)
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
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    //MARK: SearchBar
    @ViewBuilder
    func SearchBar() -> some View{
        HStack(spacing: 15) {
            Image("Search")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                .padding(.vertical, 10)
            
            Image("Mic")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical,6)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white.opacity(0.2))
        }
        .padding(.top,20)
    }
    
    //MARK: HeaderView
    @ViewBuilder
    func HeaderView() -> some View{
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                (Text("Hello")
                    .fontWeight(.semibold) +
                Text("Aki")
                ).font(.title2)
                
                Text("see featured solution")
                    .font(.callout)
                    .foregroundColor(.gray)

            }.frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                print("")
            } label: {
                Image("")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
        }
    }
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
    }
}
