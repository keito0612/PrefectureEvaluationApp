//
//  User.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation
import FirebaseFirestoreSwift
struct User: Identifiable {
    @DocumentID var id: String?
    var name : String?
    var likeNumber:Int?
    var visitedPrefectureNumber: Int?
    var evaluationNumber: Int?
    var photo: String?
    init(name:String, likeNumber:Int, visitedPrefectureNumber : Int, evaluationNumber: Int, photo:String) {
        self.name = name
        self.likeNumber = likeNumber
        self.visitedPrefectureNumber = visitedPrefectureNumber
        self.evaluationNumber = evaluationNumber
        self.photo = photo
    }
}

