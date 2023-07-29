//
//  Carousel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/21.
//

import SwiftUI

//MARK: CustomView
struct Carousel<Content: View,Item,ID>: View where Item: RandomAccessCollection,ID: Hashable, Item.Element: Equatable{
    var content: (Item.Element, CGSize)->Content
    var id: KeyPath<Item.Element,ID>
    
    //MARK: View Properties
    var spacing: CGFloat
    var cardPadding: CGFloat
    var items: Item
    @Binding var index: Int
    @StateObject var controlCellIndexRepository = ControlCellIndexRepository()
    
    init(index: Binding<Int>,items: Item,spacing: CGFloat = 30, cardPadding: CGFloat = 80, id: KeyPath<Item.Element, ID>,content: @escaping (Item.Element, CGSize) -> Content) {
        self.content = content
        self.id = id
        self.spacing = spacing
        self.cardPadding = cardPadding
        self.items = items
        self._index = index
    }
    //MARK: Gesture properties
    @GestureState var translation: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    //MARK: Rotation
    @State var rotation: Double = 0
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            let cardWidth = size.width - (cardPadding - spacing)
            LazyHStack(spacing: spacing){
                ForEach(items, id: id){solution in
                    let index = indexOf(item: solution)
                    content(solution, CGSize(width: size.width - cardPadding, height: size.height))
                    
                    //MARK: Rotating Each View 5 Deg Multiplied With it's Index
                    //All While Scrolling Setting it to 0, thus it will give some nice Circular Carousel Effect
                        .rotationEffect(.init(degrees: Double(index) * 5),anchor: .bottom)
                        .rotationEffect(.init(degrees: rotation), anchor: .bottom)
                    //MARK: Apply After Rotation, Thus you will get smooth effect
                    //セルの高さを調節しているため、原因ではなさそう
                        .offset(y: offsetY(index: index, cardWidth: cardWidth))
                        .frame(width: size.width - cardPadding, height: size.height)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal,spacing)
            .offset(x: limitScroll())
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged{onChanged(value:$0, cardWidth: cardWidth)}
                    .onEnded{onEnd(value:$0, cardWidth: cardWidth)}
            )
        }
        .padding(.top,60)
        .onAppear{
            let extraSpace = (cardPadding/2) - spacing
            offset = controlCellIndexRepository.offSet ?? extraSpace
            lastStoredOffset = controlCellIndexRepository.offSet ?? extraSpace
        }
        .onDisappear{
            controlCellIndexRepository.offSet = self.offset
        }
        .animation(.easeInOut, value: translation == 0)
    }
    
    //MARK: Moving Current Item Up
    func offsetY(index: Int, cardWidth: CGFloat) -> CGFloat{
        //MARK: We are converting the current translation, not whole offset
        //That's why created @Gesturestate to hold the current translation data
        //Converting translation to -60 ... 60
        let progress = ((translation < 0 ? translation : -translation)/cardWidth) * 60
        print("translation: \(translation)")
        print("progress: \(progress)")
        let yOffset = -progress < 60 ? progress : -(progress + 120)
        
        //MARK: Checking previous, next and in-between offsets
        let previous = (index - 1) == self.index ? (translation < 0 ? yOffset : -yOffset) : 0
        let next = (index + 1) == self.index ? (translation < 0 ? -yOffset : yOffset) : 0
        let In_Between = (index - 1) == self.index ? previous:next
        
        return index == self.index ? -60 - yOffset : In_Between
    }
    
    //MARK: Item Index
    func indexOf(item: Item.Element) -> Int{
        let array = Array(items)
        if let index = array.firstIndex(of: item){
            return index
        }
        return 0
    }
    
    //MARK: Limiting Scroll On First And Last Items
    func limitScroll ()-> CGFloat{
        let extraSpace = (cardPadding/2) - spacing
        if index == 0 && offset > extraSpace{
            print("firstOffset: \(offset)")
            return offset/4
        }else if index == items.count - 1 && translation < 0{
            return offset - (translation/2)
        }else{
            print("offset: \(offset)")
            return offset
        }
    }
    
    func onChanged(value: DragGesture.Value, cardWidth: CGFloat){
        let translationX = value.translation.width
        offset = translationX + lastStoredOffset
        
        //MARK: Caluculating Rotation
        let progress = offset / cardWidth
        rotation = progress * 5
    }
    
    func onEnd(value: DragGesture.Value, cardWidth: CGFloat){
        // MARK: Finding Current Index
        var _index = (offset/cardWidth).rounded()
        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)
        
        currentIndex = Int(_index)
        //MARK: updating Index
        //Note Since We're Moving On Right Side
        //So All Data will be Negative
        index = -currentIndex
        withAnimation(.easeInOut(duration: 0.25)){
            //MARK: Removing extra space
            let extraSpace = (cardPadding/2) - spacing
            offset = (cardWidth * _index) + extraSpace
            
            //MARK: Caluculating Rotation
            let progress = offset / cardWidth
            //Since Index Starts with zero
            rotation = (progress * 5).rounded() - 1
            print(rotation)
        }
        lastStoredOffset = offset
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
    }
}
