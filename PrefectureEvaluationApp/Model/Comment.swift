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
    let star :Double
    let scoreList:Array<Int>
    let goodComment:String
    let badComment:String
    init(star: Double ,scoreList:Array<Int>, goodComment: String, badComment: String) {
        self.star = star
        self.scoreList = scoreList
        self.goodComment = goodComment
        self.badComment = badComment
    }
}
