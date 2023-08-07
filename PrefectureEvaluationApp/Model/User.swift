//
//  User.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation

struct User: Identifiable {
    let id : Int?
    let name : String?
    let email: String?
    let password: String?
    init(id:Int ,name:String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}

