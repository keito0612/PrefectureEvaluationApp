//
//  ContentView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/05.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    init(){
        UITabBar.appearance().backgroundColor = .white
    }
    var body: some View {
        ZStack{
            TabView (selection: $selection){
                MapViewPage()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("マップ")
                    }.tag(0)
                
                Text("Bookmark Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Bookmark")
                    }.tag(1)
                
                Text("Video Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "video.circle.fill")
                        Text("Video")
                    }.tag(2)
                
                ProfileViewPage()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("プロフィール")
                    }.tag(3)
            }.background(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CityCommentPostViewModel())
    }
}
