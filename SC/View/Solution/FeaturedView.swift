//
//  FeaturedView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/14.
//

import SwiftUI

struct FeaturedView: View {
    @State var searchText: String = ""
    @Namespace var animation
    
    @State var currentIndex: Int = 0
    @StateObject var viewModel = FetchSCViewModel()
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                SCBackgroundView()
                VStack(spacing: 15){
                    HeaderView(viewModel: viewModel)
                    SearchBar(viewModel: viewModel)
                    //MARK: Custom Carousel
                    Carousel(index: $currentIndex, items: viewModel.solutions, cardPadding: 150, id: \.id) { solution,cardSize in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .frame(width: cardSize.width, height: cardSize.height)
                                .opacity(0.1)
                                .background(
                                    Color.white.opacity(0.08)
                                        .blur(radius: 10)
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            .linearGradient(.init(colors: [
                                                Color("CirclePink2"),
                                                Color("CirclePink2").opacity(0.5),
                                                .clear,
                                                Color("CirclePink1"),
                                                Color("CirclePink1"),
                                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                            ,lineWidth: 2.5
                                        )
                                        .padding(2)
                                )
                                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Text(solution.problem)
                                        .frame(width: cardSize.width - 40,height: 50,alignment: .leading)
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                                .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
                                
                                HStack {
                                    Text(solution.solution)
                                        .frame(width: cardSize.width - 40,height: cardSize.height - 50,alignment: .topLeading)
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal,-15)
                        .padding(.vertical)
                    }
                }
                .padding([.horizontal, .top],15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .onAppear{
            Task{
                try await viewModel.fetchFeaturedSolutions()
            }
        }
    }
    
    //MARK: SearchBar
    @ViewBuilder
    func SearchBar(viewModel: FetchSCViewModel) -> some View{
        HStack(spacing: 15) {
            Image("Search")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.gray)
            
            TextField("Search", text: $searchText,onEditingChanged: { start in
                if !start{
                    Task{
                       try await viewModel.fetchExploredSolutions(text: searchText)
                    }
                }
            })
                .padding(.vertical, 10)
        }
        .padding(.horizontal)
        .padding(.vertical,6)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white.opacity(0.2))
        }
        .padding(.top,20)
    }
}

//MARK: HeaderView
@ViewBuilder
func HeaderView(viewModel: FetchSCViewModel) -> some View{
    HStack {
        VStack(alignment: .leading, spacing: 6) {
            NavigationLink(destination: SCListView().onDisappear(perform: {
                Task{
                    try await viewModel.fetchFeaturedSolutions()
                }
            })){
                (Text("Hello")
                    .fontWeight(.semibold) +
                 Text("Aki")
                ).font(.title2)
                
                Text("see featured solution")
                    .font(.callout)
                    .foregroundColor(.gray)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        Button {
            print("")
        } label: {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .background{
                    Circle().stroke(
                        Color("CirclePink1")
                    )
                }
        }
    }
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
    }
}
