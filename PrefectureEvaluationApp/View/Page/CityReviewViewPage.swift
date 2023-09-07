//
//  CityReviewViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI
import FirebaseFirestore


struct CityReviewViewPage: View {
    
    let cityName:String?
    @StateObject  var cityReviewViewModel  = CityReviewViewModel()
    @Environment(\.dismiss) var dismiss
    @State var isShowAlert = false
    @State var errorMessage:String = ""
    @State var scores:Array<Int> = [0,0,0,0,0]
    
    init(cityName: String?) {
        self.cityName = cityName
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.white
                ScrollView {
                    VStack{
                        ImageWithStarWithNameView(cityName: cityName!, star: 5.0)
                        Divider()
                        ReviewRaderView(scores: $scores)
                        
                    }.task {
                        do{
                            try await cityReviewViewModel.getCityData()
                            cityReviewViewModel.cityReviewViewState = .data
                        }catch{
                            isShowAlert = true
                            cityReviewViewModel.cityReviewViewState = .error
                            let errorCode = FirestoreErrorCode.Code(rawValue:  error._code )
                           errorMessage = FirebaseErrorHandler.FireStoreErrorToString(error: errorCode!)
                        }
                    }.padding()
                }.presentationDetents(   [.medium, .large]).presentationBackground(.ultraThinMaterial)
                if(cityReviewViewModel.cityReviewViewState == .isLoading){
                    LoadingView(scaleEffect: 3)
                }
            }.navigationBarTitle(Text(""), displayMode: .inline).toolbarBackground(Color.white,for: .navigationBar).navigationBarItems(leading: Button(action:{
                
                dismiss()
            }){ Text("戻る")},trailing: NavigationLink {
                // 遷移先のビューを指定
                CityCommentPostViewPage()
            } label: {
                // リンクボタンのテキストを指定
                Text("投稿")
            })
        }.navigationBarBackButtonHidden(true)
    }
}


private struct ImageWithStarWithNameView :View{
    let cityName:String
   @State var star:Double
    var body: some View{
        VStack{
            Image("Noimage").resizable() .scaledToFill().frame(width: 400,height: 250).clipShape(Rectangle())
            VStack(alignment: .leading){
                HStack{
                    Text(cityName).font(.system(size: 30)).foregroundColor(.black).padding()
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

private struct CommnetView :View{
    var body: some View{
        VStack{
            Text("口コミ").frame(maxWidth: .infinity, alignment: .center).foregroundColor(Color.white).font(.system(size:20)).padding(.bottom)
            CommnentListView(commentList: [])
             Spacer()
        }.padding(10).frame(width: 370, height: 400).background(.ultraThinMaterial).cornerRadius(24).shadow(radius: 20)
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


private struct CommnentListView :View{
    let commentList :Array<City>
    init(commentList: Array<City>) {
        self.commentList = commentList
    }
    var body: some View {
        List(commentList){ comment in
            CommentListTile(cityData: comment)
        }.listRowBackground(Color.red).scrollContentBackground(.hidden).background(.ultraThinMaterial).cornerRadius(24)
    }
}

private struct CommentListTile :View{
    let cityData:City
    init(cityData: City) {
        self.cityData = cityData
    }
    var body: some View{
        VStack{
            StarReviewView(star: cityData.star)
            Text(cityData.comment)
        }
    }
}

struct CityReviewViewPage_Previews: PreviewProvider {
    static var previews: some View {
        CityReviewViewPage(cityName: "福岡市")

    }
}
