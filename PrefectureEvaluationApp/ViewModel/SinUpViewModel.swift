//
//  SinUpViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/29.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
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
    @Published var alertTitle: String = ""
    @Published var alertMessage : String = ""
    @Published var alertType: AlertType = .warning
    private let db = Firestore.firestore()
    
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
            let userId =  try await Auth.auth().createUser(withEmail: email , password: password).user.uid
            try await db.collection("users").document(userId).setData(["name":"", "likeNumber":0,"visitedPrefectureNumber": 0, " evaluationNumber":0 , "photo":0])
            
            sinUpModelState = .data
            alertMessage = "新規登録が完了しました。"
            alertType = .warning
            isShowAlert = true
        }catch{
            alertType = .error
            sinUpModelState = .error
            isShowAlert = true
            let authErrorCode = AuthErrorCode.Code(rawValue: error._code)
            let fireStoreError = FirestoreErrorCode.Code(rawValue: error._code)
            if(authErrorCode != nil){
                alertTitle = FirebaseErrorHandler.authErrorToString(error: authErrorCode!)
                alertMessage = FirebaseErrorHandler.authErrorMessageToString(error: authErrorCode!)
            }else if(fireStoreError != nil){
                alertTitle = FirebaseErrorHandler.FireStoreErrorToString(error: fireStoreError!)
                alertMessage = FirebaseErrorHandler.FireStoreErrorMessageToString(error: fireStoreError!)
            }
            
        }
    }
    
    
    
    
    
}
