//
//  MyPageViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/04.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

enum MyPageViewModelState{
    case isLoading
    case error
    case data
}



class MyPageViewModel : ObservableObject{
    @Published  var userData: User = User(name: "", likeNumber: 0, visitedPrefectureNumber: 0, evaluationNumber: 0, photo: "")
   @Published var myPageViewModelState :MyPageViewModelState = .isLoading
    
    private let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    
    
    
    @MainActor
    func getUserData() async throws {
        self.myPageViewModelState = .isLoading
        
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
                        return User(name: name , likeNumber: likeNumber, visitedPrefectureNumber:visitedPrefectureNumber,evaluationNumber: evaluationNumber, photo: photo )
                   }!
                }
            }
            self.myPageViewModelState = .data
        }catch{
            self.myPageViewModelState = .error
            
        }
    }
}


