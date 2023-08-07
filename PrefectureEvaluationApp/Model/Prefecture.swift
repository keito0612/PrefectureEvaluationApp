//
//  Prefecture.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation

struct Prefecture: Identifiable {
    let id = UUID()
    let star : Int
    let citys : Array<String>?
    init(star: Int ,citys:Array<String>?) {
        self.star = star
        self.citys = citys
    }
}

