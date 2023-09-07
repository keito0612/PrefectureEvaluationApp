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
                MyPageViewPage()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("マイページ")
                    }.tag(1)
            }.background(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
