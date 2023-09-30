//
//  Review.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/06.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct Review: Identifiable,Codable,Hashable{
    @DocumentID var id: String?
    let userId :String?
    var star: Double
    var scoreList: Array<Double>?
    var goodComment:String?
    var badComment :String?
    var photos:Array<String>?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    var user : User?
}
