//
//  Util.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/20.
//

import Foundation
class UtilDate{
    private let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "YYYY/MM/dd(E)HH:mm"
        dateFormatter.locale = Locale(identifier: "ja_jp")
    }
    func TimestampToString(date : Date) -> String {
        let dateTime = dateFormatter.string(from: date)
        return dateTime
    }
}
