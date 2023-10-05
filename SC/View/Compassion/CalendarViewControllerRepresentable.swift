////
////  CalendarViewControllerRepresentable.swift
////  SC
////
////  Created by 伊藤明孝 on 2023/10/05.
////
//
//import Foundation
//import SwiftUI
//struct CalendarViewControllerRepresentable: UIViewControllerRepresentable{
//
//    @StateObject private var viewModel: CalendarViewModel = .init()
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//        return HostedCalendarViewController(didSelectDateSubject: viewModel.didSelectDateSubject, judgeShowingAddViewSubject: viewModel.isShowingAddView)
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        <#code#>
//    }
//}
