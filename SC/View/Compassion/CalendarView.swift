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
    
    init(didSelectDateSubject: PassthroughSubject<DateComponents, Never>, judgeShowingAddViewSubject: PassthroughSubject<Bool, Never>) {
        self.didSelectDateSubject = didSelectDateSubject
        self.judgeShowingAddViewSubject = judgeShowingAddViewSubject
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var dateComponent: DateComponents?
    
    func makeUIView(context: Context) -> some UIView {
        let calendarView = UICalendarView()
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ja")
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendarView.selectionBehavior = selection
        return calendarView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    class Coordinator: NSObject, UICalendarSelectionSingleDateDelegate {
        @ObservedObject var viewModel: CalendarViewModel = .init()
        private var parent: CalendarView
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateComponents = dateComponents else {return}
            //MARK: Published data
            parent.didSelectDateSubject.send(dateComponents)
            viewModel.dateComponents = dateComponents
            parent.judgeShowingAddViewSubject.send(true)
        }
    }
}


