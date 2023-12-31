//
//  City.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation
import FirebaseFirestoreSwift
struct City:Identifiable, Codable{
    @DocumentID var id: String?
    let star: Double
    let comment: String
    init(star: Double, comment: String) {
        self.star = star
        self.comment = comment
    }
}
