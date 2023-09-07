//
//  ProfileSettingViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/30.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

enum ProfileViewModelState{
    case isLoading
    case error
    case data
}




class ProfileViewModel : ObservableObject{
    @Published  var userData: User = User(name: "", likeNumber: 0, visitedPrefectureNumber: 0, evaluationNumber: 0, photo: "")
   @Published var profileViewModelState :ProfileViewModelState = .isLoading
    @Published var reviewList:Array<Review> = []
    private let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    @MainActor
    func getUserData() async throws {
        self.profileViewModelState = .isLoading
        
        do{
            if(userId != nil){
                let document =  try await db.collection("users").document(userId!).getDocument()
                if(document.data() != nil ){
                    self.userData = document.data().map{ doc in
                        let name = doc["name"] as? String ?? ""
                        let likeNumber = doc["likeNumber"] as? Int ?? 0
                        let visitedPrefectureNumber = doc["visitedPrefectureNumber"] as? Int ?? 0
                        let evaluationNumber = doc["evaluationNumber"] as? Int ?? 0
                        let photo = doc["photo"] as? String ?? ""
                        return User(name: name , likeNumber: likeNumber, visitedPrefectureNumber: visitedPrefectureNumber,evaluationNumber: evaluationNumber, photo: photo)
                    }!
                }
            }
            self.profileViewModelState = .data
        }catch{
            self.profileViewModelState = .error
            
        }
    }
}

