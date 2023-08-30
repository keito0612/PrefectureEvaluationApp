//
//  SwiftUIView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/13.
//

extension View {
    func customAlert( title: String?, message: String?, isPresented: Binding<Bool>,alertType:AlertType) -> some View {
        self.modifier(CustomAlert(
            isPresented: isPresented,
            title: title,
            message: message,
            alertType: alertType
        ))
    }
}


 enum AlertType {
    case warning
    case error
}


import SwiftUI
struct CustomAlert: ViewModifier {
    
    @Binding var isPresented: Bool

    let title: String?
    let message: String?
    let alertType:AlertType

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                CustomAlertControllerWithTextFieldContainer(
                                                      isPresented: $isPresented,
                                                      title: title,
                                                      message: message,
                                                      alertType: alertType
                )
            }
        }
    }
}
