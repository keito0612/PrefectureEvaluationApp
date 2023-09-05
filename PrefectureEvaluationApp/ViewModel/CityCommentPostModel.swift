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

enum CityCommetPostViewState{
    case isLoading
    case error
    case data
}

class CityCommentPostViewModel: NSObject ,ObservableObject {
    
     let userID = Auth.auth().currentUser?.uid
    @Published var star: Double = 0.0
    @Published var errorText: String = ""
    @Published var goodComment:String = ""
    @Published var badComment:String = ""
    @Published var reviewScoreList : Array<Int> = [0,0,0,0,0]
    @Published var selectedPhotos = [UIImage]()
    
    private var db = Firestore.firestore()
    
    func addComment(ReviewData : Review)  throws  {
        if(ReviewData.goodComment.isEmpty){
            errorText = "良いところの欄が入力されてません。"
            throw NSError(domain: "error", code: -1, userInfo: nil)
        }
        if(ReviewData.badComment.isEmpty){
            errorText = "悪いところの欄が入力されていません。"
            throw NSError(domain: "error", code: -1, userInfo: nil)
        }
         db.collection("comments").addDocument(data: ["star": ReviewData.star,"scoreList": [ReviewData.scoreList] ,"goodComment": ReviewData.goodComment, "badComment":  ReviewData.badComment])
    }
    
    func upLoadImage(images:Array<UIImage>) async throws{
        for ( index ,image) in images.enumerated() {
            guard let uploadImage = image.jpegData(compressionQuality: 0.5) else {
                break
            }
            let path = "gs://prefectureevaluation.appspot.com"
            let storage = Storage.storage()
            let reference = storage.reference(forURL: path).child("comment/\(getUserId())/images/image\(index).jpg")
            
            _ =  try await reference.putDataAsync( uploadImage,metadata: nil, onProgress: nil)
            
        }
    }
    private func getUserId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
}
