//
//  CityComment.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/16.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

enum CityReviewPostViewState{
    case isLoading
    case error
    case data
}

class CityReviewPostViewModel: NSObject ,ObservableObject {
    let userID = Auth.auth().currentUser?.uid
    @Published var star: Double = 0.0
    @Published var alertTitle:String = ""
    @Published var alertMessage:String = ""
    @Published var goodComment:String = ""
    @Published var badComment:String = ""
    @Published var reviewScoreList : Array<Double> = [0,0,0,0,0]
    @Published var selectedPhotos = [UIImage]()
    @Published var isShowAlert: Bool = false
    @Published var alertType :AlertType = .warning
    @Published var cityReviewPostViewState:CityReviewPostViewState = .data
    var photos :Array<String> = []
    
    private var db = Firestore.firestore()
    
    @MainActor
    func addReview(prefectureName:String, cityName:String)  async throws  {
        cityReviewPostViewState = .isLoading
        do{
            
            if(goodComment.isEmpty){
                isShowAlert = true
                alertTitle = "良いところの欄が入力されてません。"
                alertMessage = ""
                alertType = .error
                cityReviewPostViewState = .error
                return
            }
            if(badComment.isEmpty){
                isShowAlert = true
                alertTitle = "悪いところの欄が入力されていません。"
                alertMessage = ""
                alertType = .error
                cityReviewPostViewState = .error
                return
            }
            
            
            if(selectedPhotos != []){
                try await upLoadImage(images: selectedPhotos,prefectureName: prefectureName,cityName: cityName)
                
                print(photos)
            }
            
            var reviewData: Review = Review(userId:getUserId(), star: star, scoreList: reviewScoreList, goodComment: goodComment, badComment: badComment,photos:photos)
            
            try db.collection("users").document(getUserId()).collection("reviews").addDocument(from: reviewData)
            try  db.collection("prefectures").document(prefectureName).collection("reviews").addDocument(from: reviewData)
            try db.collection("prefectures").document(prefectureName).collection("citys").document(cityName).collection("reviews").addDocument(from: reviewData)
            
            isShowAlert = true
            alertType = .warning
            alertTitle = "投稿しました。"
            alertMessage = ""
            cityReviewPostViewState = .data
        }catch{
            isShowAlert = true
            alertType = .error
            cityReviewPostViewState = .error
            let errorCode = FirestoreErrorCode.Code(rawValue: error._code)
            alertTitle = FirebaseErrorHandler.FireStoreErrorToString(error: errorCode!)
            alertMessage = FirebaseErrorHandler.FireStoreErrorMessageToString(error: errorCode!)
        }
    }
    
    func upLoadImage(images:Array<UIImage>,prefectureName:String, cityName:String) async throws{
        do {
            for ( index ,image) in images.enumerated() {
                guard let uploadImage = image.jpegData(compressionQuality: 0.5) else {
                    break
                }
                let path = "gs://prefectureevaluation.appspot.com"
                let storage = Storage.storage()
                let prefectureReference = storage.reference(forURL: path).child("reviewImage/\(prefectureName)/images/image\(index).jpg")
                let cityReference = storage.reference(forURL: path).child("reviewImage/\(prefectureName)/\(cityName)/images/image\(index).jpg")
                
                _ =  try await prefectureReference.putDataAsync( uploadImage,metadata: nil, onProgress: nil)
                _ =  try await cityReference.putDataAsync( uploadImage,metadata: nil, onProgress: nil)
                let url = try await cityReference.downloadURL()
                self.photos.append(url.absoluteString)
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    private func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
}
