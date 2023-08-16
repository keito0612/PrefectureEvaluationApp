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
    let goodOfficeComent:String
    let badOfficeComment:String
    init(star: Int,goodOfficeComent: String, badOfficeComment: String) {
        self.star = star
        self.goodOfficeComent = goodOfficeComent
        self.badOfficeComment = badOfficeComment
    }
}
