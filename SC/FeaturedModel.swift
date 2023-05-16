//
//  FeaturedModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/16.
//

import Foundation
struct Movie: Identifiable, Equatable{
    var id = UUID().uuidString
    var movieTitle: String
    var artwork: String
}

var movies: [Movie] = [

]
