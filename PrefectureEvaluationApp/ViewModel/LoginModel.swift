//
//  LoginModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/29.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
enum LoginModelState{
    case isLoading
    case error
    case data
}


class LoginModel : ObservableObject{
  @Published var email: String = ""
  @Published var password:String = ""
  @Published var isShowAlert :Bool = false
  @Published var loginModelState: LoginModelState = .data
  @Published var alertMessage : String = ""
  @Published var alertType: AlertType = .warning
    @MainActor
    func login() async throws{
        loginModelState = .isLoading
        if(email.isEmpty){
            alertType = .error
            isShowAlert = true
            alertMessage = "メールアドレスを入力しください。"
            loginModelState = .data
            
        }
        if(password.isEmpty){
            alertType = .error
            isShowAlert = true
            alertMessage = "パスワードを入力してください。"
            loginModelState = .data
        }
        do{
            try await Auth.auth().signIn(withEmail: email , password: password)
            loginModelState = .data
            alertType = .warning
            isShowAlert = true
            alertMessage = "ログインが完了しました。"
        }catch{
            alertType = .error
            isShowAlert = true
            loginModelState = .error
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            alertMessage = FirebaseErrorHandler.authErrorToString(error: errorCode!)
        }
        
    }
    
}
