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
    let name : String?
    let email: String?
    let password: String?
    init(name:String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}

