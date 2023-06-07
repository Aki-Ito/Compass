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
    private let didSelectDateSubject: PassthroughSubject<Void, Never>
    
    init(didSelectDateSubject: PassthroughSubject<Void, Never>) {
        self.didSelectDateSubject = didSelectDateSubject
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
        private let parent: CalendarView
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.didSelectDateSubject.send()
        }
    }
}


