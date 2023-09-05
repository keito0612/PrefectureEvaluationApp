//
//  ProfileEditViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/01.
//

import Foundation
import Firebase
import FirebaseFirestore

enum ProfileEditViewModelState{
    case  isLoading
    case  data
    case  error
}


class ProfileEditViewModel:ObservableObject{
    private let db = Firestore.firestore()
    private let userID = Auth.auth().currentUser?.uid
    @Published var profileEditViewModelState :ProfileEditViewModelState = .data
    @Published var alertMessage = ""
    @Published var alertType: AlertType = .warning
    @Published var isShowAlert :Bool = false
    
    
    @MainActor
    func updateUser(user: User) async throws {
        do{
            profileEditViewModelState = .isLoading
            try await db.collection("users").document(userID!).updateData(["name":user.name!,
                                                                           "likeNumber":user.likeNumber!,
                                                                           "visitedPrefectureNumber":user.visitedPrefectureNumber!,
                                                                           "evaluationNumber":user.evaluationNumber!,
                                                                           "photo":user.photo!
                                                                          ])
            self.profileEditViewModelState = .data
            self.alertType = .warning
            self.alertMessage = "編集が完了しました。"
            self.isShowAlert = true
        }catch{
            self.alertType = .error
            let errorCode = FirestoreErrorCode.Code(rawValue: error._code)
            alertMessage = FirebaseErrorHandler.FireStoreErrorToString(error: errorCode!)
            self.isShowAlert = true
            self.profileEditViewModelState = .error
        }
    }
}
