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
    @Binding var allData: [CalendarModel]
    private var dateformatter = DateFormatHelper.shared
    
    
    init(didSelectDateSubject: PassthroughSubject<DateComponents, Never>, judgeShowingAddViewSubject: PassthroughSubject<Bool, Never>,allData: Binding<[CalendarModel]>) {
        self.didSelectDateSubject = didSelectDateSubject
        self.judgeShowingAddViewSubject = judgeShowingAddViewSubject
        self._allData = allData
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
        let uiview = uiView as! UICalendarView
        uiview.reloadDecorations(forDateComponents: [uiview.visibleDateComponents], animated: true)
    }
    
    class Coordinator: NSObject, UICalendarSelectionSingleDateDelegate,UICalendarViewDelegate {
        private var parent: CalendarView
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
            guard let date = dateComponents.date else {return nil}
            
            let containsCalendarData =  parent.allData.contains { calendar in
                calendar.id == parent.dateformatter.dateFormat(date: date)
            }
            if containsCalendarData{
                return .image(UIImage(systemName: "book"),color: UIColor(named: "CirclePink1"),size: .large)
            }else{
                return nil
            }
        }
    }
}


