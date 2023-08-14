//
//  Comment.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/08.
//

import Foundation
import FirebaseFirestoreSwift
struct Comment:Identifiable {
    @DocumentID var id: String?
    let star :Int
    let title:String
    let comment:String
    init(star: Int, title: String, comment: String) {
        self.star = star
        self.title = title
        self.comment = comment
    }
}
