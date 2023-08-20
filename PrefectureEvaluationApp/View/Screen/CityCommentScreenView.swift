//
//  CityCommentScreenView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/18.
//

import SwiftUI

struct CityCommentScreenView: View {
    @State var star:Int = 0
    @State var comment:String = ""
    @ObservedObject  var cityCommentPostModel:CityCommentPostViewModel = CityCommentPostViewModel()
    
    
    var body: some View {
        VStack{
            StarReviewView(star: $star ).padding(.top,10)
            RaderChartView()
            CityCommentTextField(goodComment: $cityCommentPostModel.goodComment, badComment:  $cityCommentPostModel.badComment)
            Spacer()
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
    @Binding var goodComment:String
    @Binding var badComment:String
    
    var body: some View{
        TextEditorWithPlaceholder(text: $goodComment , hintText: "良いところ")
        TextEditorWithPlaceholder(text: $badComment, hintText:"悪いところ")
    }
}




struct CityCommentScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CityCommentScreenView()
    }
}
