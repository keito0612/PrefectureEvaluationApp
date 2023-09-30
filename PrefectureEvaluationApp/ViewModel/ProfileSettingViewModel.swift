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
import PhotosUI
import SwiftUI

enum AlertType {
    case warning
    case error
}


enum ProfileSettingViewState{
    case isLoading
    case data
    case error
}


class ProfileSettingViewModel :ObservableObject{
    private let userId = Auth.auth().currentUser?.uid
    @Published var profileSettingViewModelState :ProfileSettingViewState = .data
    @Published var photo: String?
    @Published var showingImagePicker = false
    @Published var alertMessage = ""
    @Published var alertType: AlertType = .warning
    @Published var isShowAlert :Bool = false
    @Published var selectedImage: PhotosPickerItem? {
        didSet{ Task {try await upDateImage(selectedImage: selectedImage)} }
    }
    private var uiImage:UIImage?
    
    init(photo:String){
        self.photo =  photo
    }
    
    
    private  func loadImage(fromItem item:PhotosPickerItem?)async  {
        guard let item = item else{ return }
        guard let data = try? await item.loadTransferable(type: Data.self)else{return }
        guard let uiImage = UIImage(data:data) else{
            return
        }
        self.uiImage = uiImage
    }
    
    
    
    
    @MainActor
    func upDateImage(selectedImage: PhotosPickerItem?) async throws  {
        
        do{
            profileSettingViewModelState = .isLoading
            await loadImage(fromItem: selectedImage)
            if(uiImage == nil){
                return
            }
            photo =  try await upLoadImage(image: uiImage!)
            try  await Firestore.firestore().collection("users").document(userId!).updateData(["photo":  photo!])
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
    
    
    private func upLoadImage(image:UIImage) async throws ->  String?  {
        let uploadImage = image.jpegData(compressionQuality: 0.5)!
        let path = "gs://prefectureevaluation.appspot.com"
        let storageref = Storage.storage().reference(forURL: path).child("users/\(self.userId!)/profile/image/profileImage.jpg")
        do{
            _ =  try await storageref.putDataAsync( uploadImage,metadata: nil,onProgress: nil)
            let url = try await storageref.downloadURL()
            return url.absoluteString
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}

