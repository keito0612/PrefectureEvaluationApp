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
    @State var isShowAlert = false
    @State var errorMessage:String = ""
    
    init(cityName: String?) {
        self.cityName = cityName
        UITableView.appearance().backgroundColor = UIColor(Color.red)
    }
 
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack{
                        Text(cityName!).font(.system(size: 30)).foregroundColor(.white).padding(.top, 50)
                        StarReviewView(star: 3).padding()
                        ReviewRaderView().shadow(radius: 20)
                        CommnetView()
                        Spacer()
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
            }.errorAlert(title: "エラー", message: errorMessage, isPresented: $isShowAlert ).navigationBarTitle(Text(""), displayMode: .inline).toolbarBackground(Color.gray.opacity(0.2),for: .navigationBar).navigationBarItems(leading: Button(action:{
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
          StarView(star: star, size: 30)
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
            Text("口コミ").frame(maxWidth: .infinity, alignment: .center).foregroundColor(Color.white).font(.system(size:20)).padding(.bottom)
            CommnentListView(commentList: [])
             Spacer()
        }.padding(10).frame(width: 350, height: 400).background(.ultraThinMaterial).cornerRadius(24).shadow(radius: 20)
    }
    
}

private struct CommnentListView :View{
    let commentList :Array<City>
    init(commentList: Array<City>) {
        self.commentList = commentList
    }
    var body: some View {
        List(commentList){ comment in
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
            StarView(star: cityData.star, size: 10)
            Text(cityData.comment)
        }
    }
}

struct CityReviewViewPage_Previews: PreviewProvider {
    static var previews: some View {
        CityReviewViewPage(cityName: "福岡市")

    }
}
