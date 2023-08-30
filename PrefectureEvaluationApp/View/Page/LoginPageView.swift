//
//  LoginPageView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/28.
//

import SwiftUI

struct LoginPageView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var model = LoginModel()
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    EmailWithPasswordTextField(email: $model.email , password: $model.password)
                    LoginButton(model: model)
                    SinUpTextButton()
                }.frame(width: 400, height: 350).background(Color.blue).cornerRadius(30).navigationTitle("ログイン").navigationBarTitleDisplayMode(.inline).navigationBarItems(
                    leading: Button("戻る") {
                        dismiss()
                    }
                ).customAlert(title: model.alertType == .error ?  "エラーが発生しました。": "ログインが完了しました。" , message: model.alertMessage, isPresented: $model.isShowAlert, alertType: model.alertType )
                if(model.loginModelState == .isLoading){
                    LoadingView(scaleEffect: 2.0)
                }
            }
        }
    }
}

struct EmailWithPasswordTextField : View{
    @Binding var email:String
    @Binding var password:String
    var body: some View{
        VStack{
            TextField("メールアドレス",text: $email)
                .font(.system(size: 25))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("パスワード",text:$password)
                .font(.system(size: 25))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

struct LoginButton :View{
   @State  var model: LoginModel
    var body: some View{
        Button(action: {
            Task{
                try await model.login()
            }
        }){
            Text("ログイン").frame(width: 100 ,height: 50).background(.blue) .foregroundColor(.white).cornerRadius(30).shadow(radius: 30).overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color(.white), lineWidth: 3.0)
            )
        }.padding()
    }
}

private struct SinUpTextButton :View {
    @State var isPresented:Bool = false
    
    var body: some View{
        NavigationLink(destination:SinUpViewPage() ) {
            Text("新規登録はこちらから").foregroundColor(.white)
        }
    }
}




struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
