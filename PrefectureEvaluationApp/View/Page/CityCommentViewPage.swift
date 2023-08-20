//
//  CityCommentViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/14.
//

import SwiftUI

struct CityCommentPostViewPage: View {
    @State var star:Int = 0
    @State var comment:String = ""
    @State var selectedTad: Int = 0
    @StateObject var cityCommentPostViewModel:CityCommentPostViewModel = CityCommentPostViewModel()
    let pageList:Array<String> = ["口コミ","写真"]
    var body: some View {
        NavigationStack {
                ZStack {
                    Color.gray.opacity(0.2).edgesIgnoringSafeArea(.bottom)
                    VStack {
                        TopTabView(list: pageList, selectedTab: $selectedTad)
                     ScrollView {
                         if(selectedTad == 0){
                             CityCommentScreenView()
                         }else{
                             PhotoPostScreenView( selectedPhotos: $cityCommentPostViewModel.selectedPhotos )
                         }
                    }
                    }.navigationBarTitle("投稿")    .navigationBarTitleDisplayMode(.inline)
                }
        }
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



private struct StarReviewView: View{
   @Binding var star: Int
    var body: some View{
            VStack {
                Text("あなたの評価を教えてください").foregroundColor(.white).font(.system(size: 20)).padding(.bottom,15)
                HStack{
                    StarMinusButton(star: $star)
                    StarView(star: star, size: 30)
                    StarPlusButton(star: $star)
                }
                Divider()
            }
        }
}



private struct RaderChartView : View{
    
    var body : some View{
        RadarChart().frame(height: 400)
        Divider()
        
    }
}


private struct StarPlusButton :View {
    @Binding var star:Int
    
    var body: some View{
        Button(action: {
            if( star < 5){
                star += 1
            }
        } ) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
        }
    }
}


private struct ReviewScoreBar: View{
    var body: some View{
        Text("")
    }
}

private struct StarMinusButton :View {
    @Binding var star:Int
    
    var body: some View{
        Button(action: {
            if( 0 < star){
                self.star -= 1
            }
        } ) {
            Image(systemName: "minus.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
        }
    }
}

private struct CityCommentTextField : View {
    @Binding var comment:String
    var body: some View{
        TextEditorWithPlaceholder(text: $comment , hintText: "良いところ")
        TextEditorWithPlaceholder(text: $comment, hintText:"悪いところ")
    }
}

struct CityCommentViewPage_Previews: PreviewProvider {
    static var previews: some View {
        CityCommentPostViewPage()
    }
}
