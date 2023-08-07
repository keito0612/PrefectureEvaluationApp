//
//  City.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation

struct City:Identifiable{
    let id: UUID?
    let PrefectureName :String?
    let Citys: Array<String?>
    init(id: UUID?, PrefectureName: String, Citys: Array<String>) {
        self.id = id
        self.PrefectureName = PrefectureName
        self.Citys = Citys
    }
}
