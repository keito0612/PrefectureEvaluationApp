//
//  SettingModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/03.
//

import Foundation
import FirebaseAuth
class SettingModel: ObservableObject{
    @Published var isShowAlert = false
    @Published var alertType: AlertType = .warning
    @Published var alertMessage: String = ""
    
    
    func sinOut() throws {
        do {
            try Auth.auth().signOut()
            self.alertMessage = "ログアウトしました。"
            self.alertType = .warning
            self.isShowAlert = true
        } catch {
            alertType = .error
            alertMessage = "ログアウトが出来ませんでした。"
            self.isShowAlert = false
            print("エラーが発生しました。")
        }
        
    }
}
