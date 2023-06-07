//
//  CalendarViewModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/07.
//

import Foundation
import Combine
class CalendarViewModel: ObservableObject{
    private(set) var didSelectDateSubject: PassthroughSubject<Void, Never> = .init()
        private var cancellables: Set<AnyCancellable> = []
        
        init() {
            subscribeDidSelectDate()
        }
        
        private func subscribeDidSelectDate() {
            didSelectDateSubject
                .receive(on: DispatchQueue.main)
                .sink {
                    print("did select")
                }
                .store(in: &cancellables)
        }
}
