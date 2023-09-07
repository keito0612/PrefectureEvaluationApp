//
//  AuthObserver.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/06.
//

import Foundation
import FirebaseAuth
import Combine

class AuthObserver: ObservableObject {
    private var listener: AuthStateDidChangeListenerHandle!
    @Published var isSubscribed: Bool = false
    @Published var uid: String? = nil
    init() {
        self.listener = Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
        self?.isSubscribed = true
            self?.uid = user?.uid
    }
    }
    deinit {
        Auth.auth().removeStateDidChangeListener(listener!)
    self.isSubscribed = true
    }
}
