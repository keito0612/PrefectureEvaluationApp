//
//  AlertControllerWithTextFieldContainer.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/13.
//

import Foundation
import SwiftUI

struct ErrorAlertControllerWithTextFieldContainer: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool

    let title: String?
    let message: String?

    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }

    // SwiftUIから新しい情報を受け、viewControllerが更新されるタイミングで呼ばれる
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

        let alert = UIAlertController(title: title ,message: message, preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: title!, attributes: [.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        // Okボタンアクション
        let doneAction = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true){
                self.isPresented = false
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
