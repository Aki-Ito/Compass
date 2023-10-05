////
////  HostedCalendarViewController.swift
////  SC
////
////  Created by 伊藤明孝 on 2023/09/01.
////
//
//import UIKit
//import Combine
//
//class HostedCalendarViewController: UIViewController {
//    private var didSelectDateSubject: PassthroughSubject<DateComponents, Never>
//    private var judgeShowingAddViewSubject: PassthroughSubject<Bool, Never>
//    private var cancellables: Set<AnyCancellable> = []
//    private var viewModel = CalendarViewModel()
//    private var allData: [CalendarModel] = []
//    private var dateFormatter = DateFormatHelper.shared
//
//    init(didSelectDateSubject: PassthroughSubject<DateComponents, Never>, judgeShowingAddViewSubject: PassthroughSubject<Bool, Never>) {
//        self.didSelectDateSubject = didSelectDateSubject
//        self.judgeShowingAddViewSubject = judgeShowingAddViewSubject
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//        let screenSize = window.screen.bounds
//        let calendarView = UICalendarView(frame: screenSize)
//
//        //MARK: fetch data
//        self.fetchData()
//    }
//
//    //MARK: fetch data
//    private func fetchData(){
//        Task{
//            do{
//                self.allData = try await viewModel.fetchAllDiary()
//            }catch{
//                throw error
//            }
//        }
//    }
//}
//
//extension HostedCalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate{
//    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
//        guard let dateComponents = dateComponents else {return}
//        //MARK: Published data
//        didSelectDateSubject.send(dateComponents)
//        judgeShowingAddViewSubject.send(true)
//    }
//
//    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//        guard let date = dateComponents.date else {return nil}
//        var containsCalendarData =  allData.contains { calendar in
//            calendar.id == dateFormatter.dateFormat(date: date)
//        }
//        if containsCalendarData{
//            return .image(UIImage(systemName: "book"),color: UIColor(named: "CirclePink1"),size: .large)
//        }else{
//            return nil
//        }
//    }
//}
