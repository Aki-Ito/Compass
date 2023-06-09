//
//  CalendarViewModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/07.
//

import Foundation
import Combine
import FirebaseFirestore
class CalendarViewModel: ObservableObject, Identifiable{
    private(set) var didSelectDateSubject: PassthroughSubject<DateComponents, Never> = .init()
    private(set) var isShowingAddView: PassthroughSubject<Bool, Never> = .init()
    
    @Published var dateComponents: DateComponents?
    @Published var isShowing: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        subscribeDidSelectDate()
        subscribeIsShowing()
    }
    
    private func subscribeDidSelectDate() {
        didSelectDateSubject
            .receive(on: DispatchQueue.main)
            .sink {dateComponents in
                self.dateComponents = dateComponents
            }
            .store(in: &cancellables)
    }
    
    private func subscribeIsShowing(){
        isShowingAddView.receive(on: DispatchQueue.main)
            .sink { isShow in
                self.isShowing = isShow
            }
            .store(in: &cancellables)
    }
    
    func addDiary(selfkindness: String, commonHumanity: String, mindfullness: String, date: Date) async throws {
        
        try await CalendarModel.addData(selfkindness: selfkindness, commonHumanity: commonHumanity, mindfullness: mindfullness, createdAt: Timestamp(date: date))
    }
    
    func fetchDiary(createdAt: DateComponents) async throws -> CalendarModel?{
        do{
            guard let data = try await CalendarModel.fetchData(createdAt: createdAt) else {return nil}
            return data
        }catch{
            throw error
        }
    }
}
