//
//  ErrorDialogView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI

struct ErrorDialogView: View {
    @Binding private var errorAlert: Bool
    private var error: String
    
    init( errorAlert:Binding<Bool> , error:String){
        self._errorAlert = errorAlert
        self.error = error
    }
    var body: some View {
          alert(isPresented: $errorAlert) {
              Alert(title: Text("エラーが発生しました。"),
                    message: Text(error),
                    dismissButton: .default(Text("OK")))// 右ボタンの設定
          }
      }
  }

