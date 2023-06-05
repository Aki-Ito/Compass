//
//  CalendarView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/05.
//

import Foundation
import UIKit
import SwiftUI
struct CalendarView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        UICalendarView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
