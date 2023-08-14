//
//  CtiyReviewViewModel.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/08.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum  CityReviewViewState {
    case isLoading
    case error
    case data
}

class CityReviewViewModel : ObservableObject {
    @Published  var cityDataList: Array<City> = []
    @Published   var cityReviewViewState =  CityReviewViewState.isLoading
    
    private var db = Firestore.firestore()
    
    func getCityData()  async throws {
            let documents = try await
            db.collection("ctiyReviewDate").getDocuments().documents
        cityDataList = documents.compactMap{try? $0.data(as: City.self)}
        }
    }

