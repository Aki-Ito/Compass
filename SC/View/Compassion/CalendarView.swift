//
//  CalendarView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/05.
//

import Foundation
import UIKit
import SwiftUI
import Combine

struct CalendarView: UIViewRepresentable {
    private var didSelectDateSubject: PassthroughSubject<DateComponents, Never>
    private var judgeShowingAddViewSubject: PassthroughSubject<Bool, Never>
    @State var allData: [CalendarModel] = []
    @ObservedObject var viewModel: CalendarViewModel = .init()
    private var dateformatter = DateFormatHelper.shared
    
    
    init(didSelectDateSubject: PassthroughSubject<DateComponents, Never>, judgeShowingAddViewSubject: PassthroughSubject<Bool, Never>) {
        self.didSelectDateSubject = didSelectDateSubject
        self.judgeShowingAddViewSubject = judgeShowingAddViewSubject
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let calendarView = UICalendarView()
        calendarView.delegate = context.coordinator
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ja")
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendarView.selectionBehavior = selection
        calendarView.reloadDecorations(forDateComponents: [calendarView.visibleDateComponents], animated: true)
        return calendarView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        Task{
            do{
                allData = try await viewModel.fetchAllDiary()
            }catch{
                throw error
            }
        }
        let dateComponents = allData.map { data in
            let id = data.id
            let date = dateformatter.stringToDate(string: id!)
            let timeZone =  TimeZone(identifier: "Asia/Tokyo")
            return Calendar.current.dateComponents(in: timeZone!, from: date)
        }
        let uiview = uiView as! UICalendarView
        uiview.reloadDecorations(forDateComponents: dateComponents, animated: true)
    }
    
    class Coordinator: NSObject, UICalendarSelectionSingleDateDelegate,UICalendarViewDelegate {
        @ObservedObject var viewModel: CalendarViewModel = .init()
        private var parent: CalendarView
        private var allData: [CalendarModel] = []
        private var dateformatter = DateFormatHelper.shared
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateComponents = dateComponents else {return}
            //MARK: Published data
            parent.didSelectDateSubject.send(dateComponents)
            parent.judgeShowingAddViewSubject.send(true)
        }
        
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            Task{
                do{
                    allData = try await viewModel.fetchAllDiary()
                }catch{
                    throw error
                }
            }
            
            guard let date = dateComponents.date else {return nil}
            
            for data in allData{
                if data.id == dateformatter.dateFormat(date: date){
                    return .image(UIImage(systemName: "book"),color: UIColor(named: "CirclePink1"),size: .large)
                }
            }
            return nil
        }
    }
}


