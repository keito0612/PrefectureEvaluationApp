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
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(){
                        Text(prefectureName).font(.system(size: 30)).foregroundColor(.white).padding(.top, 50)
                        
                        StarReviewView(star: 3).padding()
                        ReviewRaderView().shadow(radius: 20)
                        CitysButtom(citys: citys)
                        Spacer()
                    }.padding()
                }.presentationDetents(   [.medium, .large]).presentationBackground(.ultraThinMaterial)
            }
        }
    }
}

private struct ReviewRaderView: View{
    var body: some View{
        RadarChart().frame(width: 370,height: 400) .background(.ultraThinMaterial).cornerRadius(24)
    }
}
private struct CitysButtom: View{
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let citys:Array<String>
    @State var isPresented :Bool = false
    var body :some View{
            VStack {
                    Text("市ごとの評価").foregroundColor(.white).padding()
                    ScrollView {
                        LazyVGrid (columns: columns) {
                            ForEach(0 ..< citys.count ) { index in
                                NavigationLink(destination: CityReviewViewPage(cityName: self.citys[index])) {
                                    Text(citys[index]).frame(width: 130,height: 50 ).padding(5).overlay(
                                      RoundedRectangle(cornerRadius: 20)
                                          .stroke(Color.blue, lineWidth: 3)
                                    )
                                }
                            }.navigationBarTitleDisplayMode(.inline)
                        }
                    }
            }.font(.system(size: 20)).frame(width: 370,height: 250).background(.ultraThinMaterial).cornerRadius(24).shadow(radius: 20).padding(.all)
        }
    }
    
    private struct StarReviewView: View{
        let star: Int
        var body: some View{
            VStack {
                Text("評価").foregroundColor(.white).font(.system(size: 20)).padding(.bottom,5)
                HStack{
                    ForEach(0..<5){ index in
                        Image(systemName:  index < star ?  "star.fill" : "star" ).foregroundColor(Color.yellow).font(.system(size: 30))
                    }
                }
            }.frame(width: 370, height: 80).background(.ultraThinMaterial).cornerRadius(24).shadow(radius: 20)
        }
    }
    
    
    
struct ReViewPage_Previews: PreviewProvider {
        static var previews: some View {
            ReViewPage(prefectureName: "福岡県",citys: ["福岡市","久留米市","飯塚市"])
        }
    }

