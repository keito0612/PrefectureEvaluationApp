//
//  CityCommentViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/14.
//

import SwiftUI

struct CityReviewPostViewPage: View {
    let prefectureName:String
    let cityName:String
    @State var selectedTad: Int = 0
    @StateObject var model:CityReviewPostViewModel = CityReviewPostViewModel()
    @Environment(\.uid) var uid
    @Environment(\.subscribedAuth) var isSubscribed
    @Environment(\.dismiss) var dismiss
    
    let pageList:Array<String> = ["口コミ","写真"]
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.bottom)
                VStack {
                    TopTabView(list: pageList, selectedTab: $selectedTad)
                    ScrollView {
                        if(selectedTad == 0){
                            CityCommentScreenView( model: model)
                        }else{
                            PhotoPostScreenView(model: model)
                        }
                    }
                }.navigationBarTitle("投稿")    .navigationBarTitleDisplayMode(.inline) .navigationBarItems(
                    trailing: Button("投稿") {
                        Task{
                            try await model.addReview(prefectureName: prefectureName, cityName: cityName)
                        }
                    }
                )
                .alert(isPresented: $model.isShowAlert) {
                    switch model.alertType {
                    case .warning:
                        return Alert(title: Text(model.alertTitle),
                                     message:  Text(model.alertMessage),
                                     dismissButton: .default(Text("OK")){
                            dismiss()
                        })
                    case .error:
                        return Alert(title: Text(model.alertTitle),message: Text(model.alertMessage),
                                   dismissButton: .default(Text("OK")))
                    }
                  }
                if(model.cityReviewPostViewState == .isLoading){
                    LoadingView(scaleEffect: 3)
                }
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






struct CityReviewPostViewPage_Previews: PreviewProvider {
    static var previews: some View {
        CityReviewPostViewPage(prefectureName: "大分県", cityName: "大分市")
    }
}
