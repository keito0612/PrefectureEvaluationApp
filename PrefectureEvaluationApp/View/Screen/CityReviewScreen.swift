//
//  CityReviewScreen.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/18.
//

import SwiftUI
import Kingfisher
import ImageViewerRemote
struct CityReviewScreen: View {
    @ObservedObject var model:CityReviewViewModel
    var body: some View {
        ScrollView{
            if(model.cityReviewDataList.last?.user != nil){
                VStack(alignment: .leading){
                    ForEach(model.cityReviewDataList){ review  in
                        ReviewListTileView(review: review)
                        Divider()
                    }
                }
            }else{
                Text("現在クチコミはありません。")
            }
        }
    }
}





struct ReviewListView: View{
    let reviews :Array<Review>
    var body: some View{
        List(reviews){ review in
            ReviewListTileView(review: review)
        }
    }
}


struct ReviewListTileView: View{
    let review : Review
    var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State var showImageViewer: Bool = false
    @State  var imageUrl : String = ""
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                NavigationLink(destination: ProfileViewPage()){
                    KFImage(URL(string: review.user!.photo!))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(75)
                }
                Text(review.user!.name!).frame(maxWidth: .infinity,alignment: .
                                               leading)
                Text(UtilDate().TimestampToString(date: (review.createdAt?.dateValue())!))
            }
            HStack{
                RatingView(review.star).font(.system(size: 10)).foregroundColor(.yellow)
                Text(String(format: "%.1f", review.star)).font(.system(size: 30)).padding(.leading)
            }
            HStack{
                Text("良いところ:")
                Text(review.goodComment!)
            }.frame(height: 50) .padding(.bottom,20)
            HStack{
                Text("悪いところ:")
                Text(review.badComment!)
            }.frame(height: 50).padding(.bottom,10)
            LazyVGrid (columns: columns) {
                if(review.photos != nil ){
                    ForEach( 0..<review.photos!.count) { num in
                        KFImage(URL(string: review.photos![num]))
                            .resizable()
                            .frame(width: 180, height: 150).cornerRadius(10)
                            .onTapGesture {
                                showImageViewer = true
                                imageUrl = review.photos![num]
                            }.padding(.leading, 5)
                    }
                }else{
                    ForEach(0..<4){_ in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: 180, height: 180)
                                .cornerRadius(10)
                            ProgressView() .progressViewStyle(.circular)
                                .foregroundColor(.white)
                                .frame(width: 10, height: 10)
                        }
                    }
                    
                }
            }
        }.padding(.all,5) .fullScreenCover(isPresented: $showImageViewer) {
            ReviewImageViewer(showImageViewer:  $showImageViewer, imageUrl: $imageUrl)
            }
    }
}
struct ReviewImageViewer: View{
    @Binding var showImageViewer: Bool
    @Binding var imageUrl:String
    var body: some View{
        VStack{
            KFImage(URL(string: imageUrl))
                .resizable()
                .frame(width: 180, height: 150).cornerRadius(10)
        }.frame(maxWidth: .infinity, maxHeight: .infinity) .overlay(ImageViewerRemote(imageURL: self.$imageUrl, viewerShown: self.$showImageViewer))
    }
}












