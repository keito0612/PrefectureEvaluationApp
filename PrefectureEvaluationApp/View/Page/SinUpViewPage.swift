//
//  SinInViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/29.
//

import SwiftUI

struct SinUpViewPage: View {
    @StateObject private var model = SinUpModel()
    var body: some View {
        NavigationStack {
            ZStack{
                VStack{
                    SinUpEmailWithPasswordTextField(model:model)
                    SinUpButton(model: model)
                }.frame(width: 400, height: 350).background(Color.blue).cornerRadius(30).navigationTitle("新規登録").navigationBarTitleDisplayMode(.inline)
                if(model.sinUpModelState == .isLoading ){
                    LoadingView(scaleEffect: 3)
                }
            }.customAlert(title: model.alertType == .warning ? model.alertMessage :"エラーが発生しました。", message: model.alertType == .error ?     model.alertMessage : "", isPresented: $model.isShowAlert, alertType: model.alertType)
        }
    }
}




private struct SinUpEmailWithPasswordTextField : View{
    @ObservedObject var model : SinUpModel
    var body: some View{
        VStack{
                TextField("メールアドレス",text: $model.email)
                    .font(.system(size: 25))
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
          
            SecureField("パスワード",text:$model.password)
                .font(.system(size: 25))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("").foregroundColor(.red)
        }
    }
}

private struct SinUpButton :View{
     @ObservedObject  var model: SinUpModel
     @Environment(\.dismiss) var dismiss
     
    var body: some View{
        Button(action: {
            Task{
                try await model.sinUp()
            }
        }){
            Text("ログイン").frame(width: 100 ,height: 50).background(.blue) .foregroundColor(.white).cornerRadius(30).shadow(radius: 30).overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color(.white), lineWidth: 3.0)
            )
        }.padding()
    }
}



struct SinUpViewPage_Previews: PreviewProvider {
    static var previews: some View {
        SinUpViewPage()
    }
}
