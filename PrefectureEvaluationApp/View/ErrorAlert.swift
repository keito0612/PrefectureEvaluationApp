//
//  SwiftUIView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/13.
//

extension View {
    func errorAlert( title: String?, message: String?, isPresented: Binding<Bool>) -> some View {
        self.modifier(ErrorAlert(
            isPresented: isPresented,
            title: title,
            message: message
            
        ))
    }
}


import SwiftUI

struct ErrorAlert: ViewModifier {
    
    @Binding var isPresented: Bool

    let title: String?
    let message: String?

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                ErrorAlertControllerWithTextFieldContainer(
                                                      isPresented: $isPresented,
                                                      title: title,
                                                      message: message)
            }
        }
    }
}
