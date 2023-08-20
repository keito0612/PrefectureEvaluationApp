//
//  CityComment.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/16.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

enum CityCommetPostViewState{
    case isLoading
    case error
    case data
}



class CityCommentPostViewModel: NSObject ,ObservableObject {
    
    @Published var commentPostList : Array<Comment> = []
    @Published var star: Int = 0
    @Published var errorText: String = ""
    @Published var goodComment:String = ""
    @Published var badComment:String = ""
    @Published var selectedPhotos = [UIImage]()
    
    private var db = Firestore.firestore()
    
    func addCommentData(commentData : Comment) async throws  {
        if(commentData.goodComment.isEmpty){
            errorText = "良いところの欄が入力されてません。"
            throw NSError(domain: "error", code: -1, userInfo: nil)
        }
        if(commentData.badComment.isEmpty){
            errorText = "悪いところの欄が入力されていません。"
            throw NSError(domain: "error", code: -1, userInfo: nil)
        }
        try await db.collection("comment").addDocument(data: ["star": commentData.star, "goodOfficeComment": commentData.goodComment, "badComment":  commentData.badComment])
    }
    
   func addImageData(){
       
    }
}
