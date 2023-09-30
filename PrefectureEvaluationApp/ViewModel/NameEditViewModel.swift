//
//  NameEditViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


enum NameEditViewModelState{
    case isLoading
    case error
    case data
}

class NameEditViewModel : ObservableObject {
    @Published var name: String
    @Published var isShowAlert : Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage:String = ""
    @Published var alertType:AlertType = .warning
    @Published var nameEditViewModelState: NameEditViewModelState = .data
    private let db = Firestore.firestore()
    private let userID = Auth.auth().currentUser?.uid
    
    init(name:String){
        self.name = name
    }
    
    
    @MainActor
    func updateName() async  throws {
        do{
            nameEditViewModelState = .isLoading
            try await db.collection("users").document(userID!).updateData(["name":name])
            self.nameEditViewModelState = .data
            self.alertType = .warning
            self.alertTitle = "編集が完了しました。"
            self.alertMessage = ""
            self.isShowAlert = true
        }catch{
            self.alertType = .error
            let errorCode = FirestoreErrorCode.Code(rawValue: error._code)
            alertTitle = FirebaseErrorHandler.FireStoreErrorToString(error: errorCode!)
            alertMessage = FirebaseErrorHandler.FireStoreErrorToString(error: errorCode!)
            self.isShowAlert = true
            self.nameEditViewModelState = .error
        }
    }
}
