//
//  ReviewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI

struct ReViewPage: View {
    let star = 3
    let activite: Bool = false
    let prefectureName : String
    let citys : Array<String>
    @State private var gestureState : CGFloat = 300
    @State var scores:Array<Int> = [0,0,0,0,0]
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationStack{
            ZStack{
                Color.white
                ScrollView {
                    VStack(){
                        ImageWithStarWithNameView(prefectureName: prefectureName, star: 5.0)
                        Divider()
                        ReviewRaderView(scores: $scores)
                        Divider()
                        CitysButtom(citys: citys)
                        Spacer()
                    }.padding()
                }.presentationDetents(   [.medium, .large]).presentationBackground(.ultraThinMaterial)
            }
        }
    }
}

private struct ImageWithStarWithNameView :View{
    let prefectureName:String
   @State var star:Double
    var body: some View{
        VStack{
            Image("Noimage").resizable() .scaledToFill().frame(width: 400,height: 250).clipShape(Rectangle())
            VStack(alignment: .leading){
                HStack{
                    Text(prefectureName).font(.system(size: 30)).foregroundColor(.black).padding()
                    Spacer()
                }
                StarReviewView(star: star)
            }
        }
    }
}

private struct ReviewRaderView: View{
    @Binding var scores:Array<Int>
    var body: some View{
        RadarChart(scores: $scores).frame(height: 400) .background(.white)
    }
}
private struct CitysButtom: View{
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let citys:Array<String>
    @State var isPresented :Bool = false
    var body :some View{
            VStack {
                Text("市ごとの評価").foregroundColor(.black).padding()
                    ScrollView {
                        LazyVGrid (columns: columns) {
                            ForEach(0 ..< citys.count, id: \.self  ) { index in
                                NavigationLink(destination: CityReviewViewPage(cityName: self.citys[index])) {
                                    Text(citys[index]).frame(width: 150,height: 60 ).padding(5).overlay(
                                      RoundedRectangle(cornerRadius: 20)
                                          .stroke(Color.blue, lineWidth: 3)
                                    )
                                }
                            }.navigationBarTitleDisplayMode(.inline)
                        }
                    }
            }.font(.system(size: 20)).frame(width: 370,height: 250)
        }
    }
    
private struct StarReviewView: View{
     let star: Double
    var body: some View{
        HStack(){
            RatingView(star).foregroundColor(.yellow)
            Text(star.description).font(.system(size: 30)).padding(.leading)
            Spacer()
        }.padding(.leading)
        
    }
}
    
struct ReViewPage_Previews: PreviewProvider {
        static var previews: some View {
            ReViewPage(prefectureName: "福岡県",citys: ["福岡市","久留米市","飯塚市"])
        }
    }

