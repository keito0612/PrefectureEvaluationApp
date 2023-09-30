//
//  ProfilePageView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/26.
//

import SwiftUI
import Firebase

struct ProfileViewPage: View {
    @StateObject var model :ProfileViewModel = ProfileViewModel()
    
       var body: some View {
           NavigationStack {
               ZStack {
                   Color.white
                VStack{
                    ProfileView(model: model)
                }
               }.navigationBarTitle("プロフィール", displayMode: .inline)
           }
       }
}




private struct ProfileView: View{
    @ObservedObject  var model: ProfileViewModel
    var body: some View{
        HStack{
            VStack(alignment: .leading ){
                HStack{
                    ProfileImage().padding(.trailing,20)
                    VStack{
                        EvaluationNumberView()
                        VisitedPrefectureCountView()
                        LikeCountView()
                    }
                }.padding()
                NameWithRetingStarView(star: 3.3, name: "こうた")
                ReViewListView(reviewList: model.reviewList )
                Spacer()
            }
        }
    }
}

private struct NameWithRetingStarView :View{
    let star: Double
    let name: String
    var body: some View{
        HStack{
            Text(name).fontWeight(.bold).font(.system(size: 20)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading,35)
            RatingView(star).foregroundColor(.yellow).padding(.trailing)
        }.padding(.bottom)
    }
}

private struct ProfileImage: View{
  
    var body: some View{
        Circle()
            .fill(Color.gray)
            .frame( height: 100)
    }
}
private struct EvaluationNumberView: View{
    var body: some View{
        HStack{
            Text("評価数")
            Text("0").frame(maxWidth: .infinity, alignment: .trailing)
        }.padding(.vertical,5)
    }
}
private struct VisitedPrefectureCountView : View{
    var body: some View{
        HStack{
            Text("住んだ県の数")
            Text("0").frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
private struct LikeCountView : View {
    var body: some View{
        HStack{
            Text("いいね数")
            Text("0").frame(maxWidth: .infinity, alignment: .trailing)
        }.padding(.top,5)
    }
}

private struct ReViewListView :View{
    let reviewList:Array<Review>
    var body: some View{
        VStack {
            Text("クチコミ").fontWeight(.bold).font(.system(size: 20)).frame(maxWidth: .infinity).frame(height: 40).background(Color.blue).foregroundColor(.white)
            ZStack {
                List{
                    ForEach(reviewList,id: \.self){ review in
                        ReViewListTileView(review: review)
                    }
                }
                if(reviewList.isEmpty){
                    Text("クチコミがありません。")
                }
            }
        }
        
    }
}

private struct ReViewListTileView :View{
    let review:Review
    var body: some View{
        HStack {
            VStack(alignment: .leading){
                Text("いい所: \(review.goodComment!)").padding()
                Text("悪い所: \(review.badComment!)").padding()
            }
        }
    }
}




    
    struct ProfileViewPage_Previews: PreviewProvider {
        static var previews: some View {
            ProfileViewPage()
        }
    }
