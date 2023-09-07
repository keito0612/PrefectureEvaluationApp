//
//  Environment.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/06.
//

import Foundation
import SwiftUI

private struct SubscribedAuthEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

private struct UIDEnvironmentKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

extension EnvironmentValues {
    var uid: String? {
        get { self[UIDEnvironmentKey.self] }
        set { self[UIDEnvironmentKey.self] = newValue }
    }
    var subscribedAuth: Bool {
        get { self[SubscribedAuthEnvironmentKey.self] }
        set { self[SubscribedAuthEnvironmentKey.self] = newValue }
    }
}
