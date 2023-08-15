//
//  CityCommentViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/14.
//

import SwiftUI

struct CityCommentViewPage: View {
    @State var star:Int = 0
    @State var comment:String = ""
    var body: some View {
        NavigationStack {
                ZStack {
                    Color.gray.opacity(0.2).edgesIgnoringSafeArea(.bottom)
                ScrollView {
                    VStack{
                        StarReviewView(star: $star).padding(.top,10)
                        RaderChartView()
                        CityCommentTextField(comment: $comment )
                        Spacer()
                    }.navigationBarTitle("投稿")    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}


private struct StarReviewView: View{
   @Binding var star: Int
    var body: some View{
            VStack {
                Text("あなたの評価を教えてください").foregroundColor(.white).font(.system(size: 20)).padding(.bottom,15)
                HStack{
                    StarMinusButton(star: $star)
                    StarView(star: star, size: 30)
                    StarPlusButton(star: $star)
                }
                Divider()
            }
        }
}



private struct RaderChartView : View{
    
    var body : some View{
        RadarChart().frame(height: 400)
        Divider()
        
    }
}


private struct StarPlusButton :View {
    @Binding var star:Int
    
    var body: some View{
        Button(action: {
            if( star < 5){
                star += 1
            }
        } ) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
        }
    }
}


private struct ReviewScoreBar: View{
    var body: some View{
        Text("")
    }
}

private struct StarMinusButton :View {
    @Binding var star:Int
    
    var body: some View{
        Button(action: {
            if( 0 < star){
                self.star -= 1
            }
        } ) {
            Image(systemName: "minus.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
        }
    }
}

private struct CityCommentTextField : View {
    @Binding var comment:String
    var body: some View{
        TextEditorWithPlaceholder(text: $comment , hintText: "良いところ")
        TextEditorWithPlaceholder(text: $comment, hintText:"悪いところ")
    }
}

struct CityCommentViewPage_Previews: PreviewProvider {
    static var previews: some View {
        CityCommentViewPage()
    }
}
