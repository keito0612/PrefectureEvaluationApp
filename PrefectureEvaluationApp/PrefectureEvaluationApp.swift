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
        return true
    }
}


@main
struct PrefectureEvaluationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var auth = AuthObserver()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView() .environment(\.uid, auth.uid)
                .environment(\.subscribedAuth, auth.isSubscribed)
        }
    }
}
