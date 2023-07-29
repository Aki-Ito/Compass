//
//  ControlCellIndexRepository.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/07/29.
//

import Foundation
import Combine
class ControlCellIndexRepository: ObservableObject{
    @Published var currentIndex: Int?
    @Published var offSet: CGFloat?
}
