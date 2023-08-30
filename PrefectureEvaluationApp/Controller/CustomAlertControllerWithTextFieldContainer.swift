//
//  AlertControllerWithTextFieldContainer.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/13.
//

import Foundation
import SwiftUI

struct CustomAlertControllerWithTextFieldContainer: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool

    let title: String?
    let message: String?
    let alertType: AlertType

    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }

    // SwiftUIから新しい情報を受け、viewControllerが更新されるタイミングで呼ばれる
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

        let alert = UIAlertController(title: title ,message: message, preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: title!, attributes: [.foregroundColor : alertType == .warning ? UIColor.black :     UIColor.red]), forKey: "attributedTitle")
        // Okボタンアクション
        let doneAction = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true){
                self.isPresented = false
                if(alertType == .warning){
                    self.dismiss()
                    self.dismiss()
                }
            }
        }
        
        alert.addAction(doneAction)
        
        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true) {
                isPresented = false
            }
        }
    }
}
