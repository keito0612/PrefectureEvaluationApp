//
//  Review.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/06.
//

import Foundation
struct Review:Identifiable, Codable,Hashable{
    var id: String?
    var userId :String?
    var star: Double
    var scoreList: Array<Double>?
    var goodComment:String?
    var badComment :String?
    
    init(id:String, userId:String,
         star:Double,
         scoreList:Array<Double>,  goodComment:String, badComment: String) {
        self.id = id
        self.userId = userId
        self.star = star
        self.scoreList = scoreList
        self.goodComment  = goodComment
        self.badComment = badComment
    }
    
}
