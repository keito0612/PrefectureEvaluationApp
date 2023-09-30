//
//  CityCommentScreenView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/18.
//

import SwiftUI

struct CityCommentScreenView: View {
   
    @ObservedObject var model:CityReviewPostViewModel
    @FocusState var isKeybordOn :Bool
    
    var body: some View {
        VStack{
            StarReviewView(star:model.star ).padding(.top,10)
            RaderChartView(scores: $model.reviewScoreList)
            ScoreListView(star: $model.star, scores: $model.reviewScoreList ).padding(.bottom,20)
            Divider()
            CityCommentTextField(goodComment: $model.goodComment, badComment:  $model.badComment,isKeybordOn: _isKeybordOn)
            Spacer()
        }
    }
}



private struct StarReviewView: View{
    let star: Double
    var body: some View{
        VStack {
            Text("あなたの評価を教えてください").foregroundColor(.white).font(.system(size: 20))
            HStack{
                RatingView(star).foregroundColor(.yellow)
            }
            Text("\(String(format: "%.1f", star)) / 5.0").foregroundColor(.white).font(.system(size: 25))
            Divider()
        }
    }
}



private struct RaderChartView : View{
     @Binding var scores :Array<Double>
    var body : some View{
        RadarChart(scores: $scores).frame(height: 400)
        
    }
}

private struct ScoreListView :View{
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @Binding var star: Double
    @Binding var scores:Array<Double>
    let scoresTitle:Array<String> = ["役所の対応", "交通機関", "住みやすさ", "子育て", "市の制度"]
    var body: some View{
        LazyVGrid (columns: columns)
        {
            ForEach(0 ..< scores.count,id: \.self) { index in
                Menu{
                    ForEach(0 ..< scores.count + 1 ,id: \.self){ score in
                        Button("\(score)", action: {
                            scores[index] = Double(score)
                            star =  averageScore()
                        })
                    }
                }label:{
                    Text(scoresTitle[index]).frame(width:100,height: 50).background(Color.white).cornerRadius(20)
                }
            }
        }
    }
    func averageScore() -> Double {
        let averageScore = Double(scores[0] + scores[1] + scores[2] + scores[3] + scores[4]) / 5
        return  averageScore
    }
    
}

private struct CityCommentTextField : View {
    @Binding var goodComment:String
    @Binding var badComment:String
    @FocusState var isKeybordOn: Bool
    var body: some View{
        TextEditorWithPlaceholder(text: $goodComment,  hintText: "良いところ", isKeybordOn: _isKeybordOn)
        TextEditorWithPlaceholder(text: $badComment, hintText:"悪いところ", isKeybordOn: _isKeybordOn)
    }
}

