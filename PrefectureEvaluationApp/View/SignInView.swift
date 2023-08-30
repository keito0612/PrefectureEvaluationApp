//
//  SinInView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/27.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack{
            Text("利用するには、ログインが必要です。").foregroundColor(.white)
            Text("ログインするには、下のボタンからお願いします。").foregroundColor(.white)
            LoginWithSignInButton()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.gray.opacity(0.7))
    }
}
    
private struct LoginWithSignInButton : View  {
    @State var isPresented:Bool = false
    var body: some View{
        Button(action: {
            isPresented = true
        }) {
            Text("ログイン / 新規登録")
                .frame(width: 200, height: 60)
                .accentColor(Color.white)
                .background(Color.blue)
                .cornerRadius(25)
        }.fullScreenCover(isPresented: $isPresented) {
            LoginPageView()
        }
    }
}





struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
