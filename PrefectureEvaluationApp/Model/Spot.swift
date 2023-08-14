//
//  Spot.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation
import Foundation
import CoreLocation
struct Spot: Identifiable {
    let id = UUID()
    let prefectureName :String
    let latitude: Double?
    let longitude: Double?
    let citys:Array<String>
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }
}
