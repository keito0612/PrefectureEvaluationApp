//
//  CityReviewViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI

struct CityReviewViewPage: View {
    let cityName:String?
    init(cityName: String?) {
        self.cityName = cityName
        print( self.cityName!)
    }
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(){
                        Text(cityName!).font(.system(size: 30)).foregroundColor(.white).padding(.top, 50)
                        StarReviewView(star: 3).padding()
                        ReviewRaderView().shadow(radius: 20)
                        CommnetView()
                        Spacer()
                    }.padding()
                }.presentationDetents(   [.medium, .large]).presentationBackground(.ultraThinMaterial)
            }.navigationBarTitle(Text(""), displayMode: .inline).toolbarBackground(Color.gray.opacity(0.2),for: .navigationBar).navigationBarItems(leading: Button(action:{
                dismiss()
            }){ Text("戻る")},trailing:Button(action:{
                dismiss()
            }){Image(systemName: "pencil.circle.fill")})
        }.navigationBarBackButtonHidden(true)
    
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
        }.frame(width: 350, height: 80).background(.thinMaterial).cornerRadius(24).shadow(radius: 20)
    }
}
private struct ReviewRaderView: View{
    var body: some View{
        RadarChart().frame(width: 350,height: 400) .background(.ultraThinMaterial).cornerRadius(24)
    }
}

private struct CommnetView :View{
    
    var body: some View{
        VStack{
            Text("口コミ").frame(maxWidth: .infinity, alignment: .leading)
            Text("三時間前").padding(.trailing, 250).padding(.bottom, 20)
            Text("Hello, World!")
                     .frame(alignment: .leading)
             Spacer()
        }.padding(10).frame(width: 350, height: 400).background(.thinMaterial).cornerRadius(24).shadow(radius: 20)
    }
    
}

private struct CommnentListView :View{
    let commentList :Array<String>?
    init(commentList: Array<String>?) {
        self.commentList = commentList
    }
    var body: some View {
        List{
            
        }
    }
}

private struct CommentListTile :View{
    let time:String
    let star:Int
    let comment:String
    init(time: String, comment: String , star:Int) {
        self.time = time
        self.comment = comment
        self.star = star
    }
    var body: some View{
        VStack{
            Text("")
        }
    }
}

struct CityReviewViewPage_Previews: PreviewProvider {
    static var previews: some View {
        CityReviewViewPage(cityName: "福岡市")
    }
}
