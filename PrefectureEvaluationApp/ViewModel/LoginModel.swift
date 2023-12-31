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
    @Published var alertTitle: String = ""
  @Published var alertMessage : String = ""
  @Published var alertType: AlertType = .warning
    @MainActor
    func login() async throws{
     do{
        loginModelState = .isLoading
        if(email == ""){
            alertType = .error
            isShowAlert = true
            alertTitle = "メールアドレスを入力しください。"
            alertMessage = ""
            loginModelState = .error
            
        }
        if(password == ""){
            alertType = .error
            isShowAlert = true
            alertTitle = "パスワードを入力してください。"
            alertMessage = ""
            loginModelState = .error
        }
            try await Auth.auth().signIn(withEmail: email , password: password)
            loginModelState = .data
            alertType = .warning
            isShowAlert = true
            alertTitle = "ログインが完了しました。"
            alertMessage = ""
        }catch{
            alertType = .error
            isShowAlert = true
            loginModelState = .error
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            alertTitle = FirebaseErrorHandler.authErrorToString(error: errorCode!)
            alertMessage = FirebaseErrorHandler.authErrorMessageToString(error: errorCode!)
        }
        
    }
    
}
