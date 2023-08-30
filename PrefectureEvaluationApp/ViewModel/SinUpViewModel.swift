//
//  SinUpViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/29.
//

import Foundation
import FirebaseAuth
enum SinUpModelState{
    case isLoading
    case error
    case data
}


class SinUpModel : ObservableObject{
    
    @Published var email: String = ""
    @Published var password:String = ""
    @Published var isShowAlert :Bool = false
    @Published var sinUpModelState: SinUpModelState = .data
    @Published var alertMessage : String = ""
    @Published var alertType: AlertType = .warning
    
    @MainActor
    func sinUp() async throws{
        sinUpModelState = .isLoading
        if(email.isEmpty){
            alertMessage = "メールアドレスを入力してください。"
            sinUpModelState = .data
            alertType = .error
            isShowAlert = true
        }
        if(password.isEmpty){
            alertMessage = "パスワードを入力してください。"
            sinUpModelState = .data
            alertType = .error
            isShowAlert = true
        }
        do{
            try await Auth.auth().createUser(withEmail: email , password: password)
            sinUpModelState = .data
            alertMessage = "新規登録が完了しました。"
            alertType = .warning
            isShowAlert = true
        }catch{
            alertType = .error
            sinUpModelState = .error
            isShowAlert = true
            let errorCode = AuthErrorCode.Code(rawValue: error._code)
            alertMessage = FirebaseErrorHandler.authErrorToString(error: errorCode!)
        }
    }
}
