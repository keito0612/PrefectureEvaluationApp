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
    let goodComment:String
    let badComment:String
    init(star: Int,goodComment: String, badComment: String) {
        self.star = star
        self.goodComment = goodComment
        self.badComment = badComment
    }
}
