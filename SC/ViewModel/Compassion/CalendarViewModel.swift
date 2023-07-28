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
    private var dateformatter = DateFormatHelper.shared
    
    @Published var dateComponents: DateComponents?
    @Published var isShowing: Bool = false
    @Published var allData:[CalendarModel] = []
    
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
    
    public func addDiary(selfkindness: String, commonHumanity: String, mindfullness: String, date: Date) async throws {
        
        try await CalendarModel.addData(selfkindness: selfkindness, commonHumanity: commonHumanity, mindfullness: mindfullness, createdAt: Timestamp(date: date))
    }
    
    public func fetchDiary(createdAt: DateComponents) async throws -> CalendarModel?{
        do{
            guard let data = try await CalendarModel.fetchData(createdAt: createdAt) else {return nil}
            return data
        }catch{
            throw error
        }
    }
    
    @MainActor
    public func fetchAllDiary() async throws -> [CalendarModel]{
        do{
            let data = try await CalendarModel.fetchAllData()
            self.allData = data
            return data
        }catch{
            throw error
        }
    }
    
    @MainActor
    public func makeDateComponentsArray() async throws -> [DateComponents]{
        do{
            let allCompassionData = try await CalendarModel.fetchAllData()
            let dateComponentsArray = allCompassionData.map { data in
                let id = data.id
                let date = dateformatter.stringToDate(string: id!)
                let timeZone =  TimeZone(identifier: "Asia/Tokyo")
                return Calendar.current.dateComponents(in: timeZone!, from: date)
            }
            return dateComponentsArray
        }catch{
            throw error
        }
    }
}
