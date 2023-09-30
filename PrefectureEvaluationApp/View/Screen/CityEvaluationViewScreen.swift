//
//  CityEvaluationViewScreen.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/08.
//

import SwiftUI

struct CityEvaluationViewScreen: View {
    @ObservedObject var model :CityReviewViewModel
    let cityName:String
    var body: some View {
        ScrollView {
            VStack{
                ImageWithStarWithNameView(cityName: cityName, star: model.radingStarScore)
                Divider()
                ReviewRaderView(scores: $model.scores)
            }
        }
    }
}

private struct ImageWithStarWithNameView :View{
    let cityName:String
    let star:Double
    var body: some View{
        VStack{
            Image("Noimage").resizable() .scaledToFill().frame(width: 400,height: 250).clipShape(Rectangle())
            VStack(alignment: .leading){
                HStack{
                    Text(cityName).font(.system(size: 30)).foregroundColor(.black).padding(.leading)
                    Spacer()
                }
                StarReviewView(star: star)
            }
        }
    }
}


private struct ReviewRaderView: View{
    @Binding var scores:Array<Double>
    var body: some View{
        RadarChart(scores: $scores).frame(height: 400) .background(.white)
    }
}


private struct StarReviewView: View{
    let star: Double
    var body: some View{
        HStack(){
            RatingView(star).foregroundColor(.yellow)
            Text(String(format: "%.1f", star)).font(.system(size: 30)).padding(.leading)
            Spacer()
        }.padding(.leading)
        
    }
}






