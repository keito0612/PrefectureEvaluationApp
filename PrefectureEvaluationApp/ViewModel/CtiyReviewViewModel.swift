//
//  CtiyReviewViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/08.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

enum  CityReviewViewState {
    case isLoading
    case error
    case data
}

class CityReviewViewModel : ObservableObject {
    @Published var cityReviewDataList: Array<Review> = []
    @Published var cityReviewViewState =  CityReviewViewState.data
    @Published var isShowAlert = false
    @Published var alertType: AlertType = .warning
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    @Published var radingStarScore:Double = 0.0
    @Published var scores:Array<Double> = [0,0,0,0,0]

    private var db = Firestore.firestore()
    init(){
        
    }
    
    
    @MainActor
    func getCityData(prefectureName: String , cityName:String )  async throws {
        do{
            cityReviewViewState = .isLoading
            let documents =
            try await db.collection("prefectures").document(prefectureName).collection("citys").document(cityName).collection("reviews").getDocuments().documents
            cityReviewDataList =  documents.compactMap { try? $0.data(as: Review.self)}
            
            for i in 0 ..< cityReviewDataList.count {
                var cityData = cityReviewDataList[i]
                let userId  = cityData.userId
                let user = try await getUser(userId: userId!)
                self.cityReviewDataList[i].user = user
            }
           
            
            if( cityReviewDataList.isEmpty == false ){
                scores =  reviewAvarageScores(reviews:  cityReviewDataList)
                radingStarScore = reviewAvarageStarScore(cityReviewDataList:  cityReviewDataList)
                
            }
            cityReviewViewState = .data
        }catch{
            isShowAlert = true
            cityReviewViewState = .error
            let errorCode  = FirestoreErrorCode.Code(rawValue: error._code)
            errorTitle = FirebaseErrorHandler.FireStoreErrorToString(error: errorCode!)
            errorMessage = FirebaseErrorHandler.FireStoreErrorMessageToString(error: errorCode!)
        }
    }
    
    
    private func getUser(userId:String) async throws -> User{
        let document =  try await db.collection("users").document(userId).getDocument()
        print(try document.data(as: User.self))
        return try document.data(as: User.self)
    }
    
    
    private  func reviewAvarageScores(reviews:Array<Review>?) -> Array<Double>{
        var avarageScores: Array<Double> = [0,0,0,0,0]
        
        for review in reviews! {
            for  index in  0 ..< 5  {
                avarageScores[index] += review.scoreList![index]
            }
        }
        
        for index in 0..<5 {
            avarageScores[index] = avarageScores[index] / Double(reviews!.count)
        }
        
        return avarageScores
    }
    private func reviewAvarageStarScore(cityReviewDataList:Array<Review>?) -> Double {
        var avarageStarScore = 0.0
        
        for cityData in cityReviewDataList!{
            avarageStarScore += cityData.star
        }
        
        avarageStarScore = avarageStarScore / Double(cityReviewDataList!.count)
        return avarageStarScore
    }
    
    
}

