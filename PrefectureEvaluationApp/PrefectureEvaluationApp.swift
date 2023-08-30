//
//  PrefectureEvaluationAppApp.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/05.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct PrefectureEvaluationApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(CityCommentPostViewModel())
        }
    }
}
