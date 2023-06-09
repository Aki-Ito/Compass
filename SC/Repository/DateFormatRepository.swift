//
//  DateFormatRepository.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/09.
//

import Foundation
struct DateFormatRepository{
    static let shared = DateFormatRepository()
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
}
