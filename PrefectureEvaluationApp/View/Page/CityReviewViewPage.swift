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
    let prefectureName: String?
    @State var selectedTab:Int = 0
    @StateObject  var model  = CityReviewViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    init(cityName: String?,prefectureName:String?) {
        self.cityName = cityName
        self.prefectureName = prefectureName
    }
    
    let pageList:Array<String> = ["評価","クチコミ"]
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.white
                VStack {
                    TopTabView(list: pageList, selectedTab: $selectedTab)
                    
                    if(selectedTab == 0){
                        CityEvaluationViewScreen(model: model , cityName: cityName!)
                    }else{
                        CityReviewScreen(model: model)
                    }
                    } .padding().task {
                        Task{
                            try await model.getCityData(prefectureName: prefectureName!, cityName: cityName!)
                            model.cityReviewViewState = .data
                        }
                    }
                
                if(model.cityReviewViewState == .isLoading){
                    LoadingView(scaleEffect: 3)
                }
            }.presentationDetents(   [.medium, .large]).presentationBackground(.ultraThinMaterial).navigationBarBackButtonHidden(true)
    
        }.navigationBarTitle(Text(""), displayMode: .inline).toolbarBackground(Color.white,for: .navigationBar).navigationBarItems(leading: Button(action:{
            
            dismiss()
        }){ Text("戻る")},trailing: NavigationLink {
            // 遷移先のビューを指定
            CityReviewPostViewPage(prefectureName: prefectureName!, cityName: cityName!)
        } label: {
            // リンクボタンのテキストを指定
            Text("投稿")
        })
    }
}
    


private struct TopTabView: View {
    let list: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< list.count, id: \.self) { row in
                Button(action: {
                    withAnimation {
                        selectedTab = row
                    }
                }, label: {
                    VStack(spacing: 0) {
                        HStack {
                            Text(list[row])
                                .font(Font.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.primary)
                        }
                        .frame(
                            width: (UIScreen.main.bounds.width / CGFloat(list.count)),
                            height: 48 - 3
                        )
                        Rectangle()
                            .fill(selectedTab == row ? Color.blue : Color.clear)
                            .frame(height: 3)
                    }
                    .fixedSize()
                })
            }
        }
        .frame(height: 48)
        .background(Color.white)
        .compositingGroup()
        .shadow(color: .primary.opacity(0.2), radius: 3, x: 4, y: 4)
    }
}

private struct ImageWithStarWithNameView :View{
    let cityName:String
   @Binding var star:Double
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


private struct ImageView :View{
    let images:Array<Data>?
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    var body: some View{
        if(images == nil){
            Image("Noimage").resizable() .scaledToFill().frame(width: 400,height: 250).clipShape(Rectangle())
        }else{
            LazyVGrid (columns: columns) {
                ForEach(images!, id: \.self){ image in
                    Image(uiImage: UIImage(data: image)!)
                    
                }
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
            Text(String(format: "%.1f", star)).font(.system(size: 30)).padding(.leading)
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
        CityReviewViewPage(cityName: "福岡市",prefectureName: "福岡県")

    }
}
