//
//  ProfilePageView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/26.
//

import SwiftUI
import Firebase

struct ProfileViewPage: View {
    let user = Auth.auth().currentUser
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack{
                ProfileView()
            }
            if(user == nil){
                SignInView()
            }
            
        }
    }
}




private struct ProfileView: View{
    var body: some View{
        VStack{
            ProfileImage().padding()
            EvaluationNumberView()
            VisitedPrefectureCountView()
            LikeCountView()
            Spacer()
        } .frame(width: 380, height: 400).background(.blue).cornerRadius(50)
    }
}
private struct ProfileImage: View{
    let user = Auth.auth().currentUser
    var body: some View{
        if(user == nil ){
            Circle()
                .fill(Color.white)
                .frame(width: 200, height: 100)
        }else{
            
        }
    }
}
private struct EvaluationNumberView: View{
    var body: some View{
        HStack{
            Text("評価数").font(.system(size: 30)).foregroundColor(.white)
            Spacer()
            Text("0").font(.system(size: 30)).foregroundColor(.white)
        }.padding()
    }
}
private struct VisitedPrefectureCountView : View{
    var body: some View{
        HStack{
            Text("住んだ県の数").font(.system(size: 30)).foregroundColor(.white)
            Spacer()
            Text("0").font(.system(size: 30)).foregroundColor(.white)
        }.padding()
    }
}
private struct LikeCountView : View {
    var body: some View{
        HStack{
            Text("いいね数").font(.system(size: 30)).foregroundColor(.white)
            Spacer()
            Text("0").font(.system(size: 30)).foregroundColor(.white)
        }.padding()
    }
}
    
    
    struct ProfileViewPage_Previews: PreviewProvider {
        static var previews: some View {
            ProfileViewPage()
        }
    }
