//
//  CalendarViewModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/07.
//

import Foundation
import Combine
class CalendarViewModel: ObservableObject{
    private(set) var didSelectDateSubject: PassthroughSubject<DateComponents, Never> = .init()
    @Published var dateComponents: DateComponents?
        private var cancellables: Set<AnyCancellable> = []
        
        init() {
            subscribeDidSelectDate()
        }
        
        private func subscribeDidSelectDate() {
            didSelectDateSubject
                .receive(on: DispatchQueue.main)
                .sink {dateComponents in
                    self.dateComponents = dateComponents
                }
                .store(in: &cancellables)
        }
}
