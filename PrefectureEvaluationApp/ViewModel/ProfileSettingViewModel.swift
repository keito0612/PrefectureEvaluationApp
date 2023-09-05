//
//  ProfileSettingViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/31.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit
import FirebaseFirestore

enum ProfileSettingViewState{
    case isLoading
    case data
    case error
}


class ProfileSettingViewModel :ObservableObject{
    private let userId = Auth.auth().currentUser?.uid
    @Published var profileSettingViewModelState :ProfileSettingViewState = .data
    @Published var image: UIImage?
    @Published var showingImagePicker = false
    @Published var alertMessage = ""
    @Published var alertType: AlertType = .warning
    @Published var isShowAlert :Bool = false
    
    
    @MainActor
    func upLoadImage() async throws  {
        do{
            profileSettingViewModelState = .isLoading
            try await upLoad(image: image!)
            self.alertType = .warning
            self.isShowAlert = true
            self.profileSettingViewModelState = .data
        }catch{
            self.alertType = .error
            self.isShowAlert = true
            let errorCode = FirestoreErrorCode.Code(rawValue: error._code)
            alertMessage = FirebaseErrorHandler.FireStoreErrorToString(error: errorCode!)
            self.profileSettingViewModelState = .error
        }
    }
    
    
    private func upLoad(image:UIImage) async throws{
        let uploadImage = image.jpegData(compressionQuality: 0.5)!
        let path = "gs://prefectureevaluation.appspot.com"
        let storageref = Storage.storage().reference(forURL: path).child("users/\(self.userId!)/profile/image/profileImage.jpg")
       _ =  try await storageref.putDataAsync( uploadImage,metadata: nil,onProgress: nil)
        
    }
}
