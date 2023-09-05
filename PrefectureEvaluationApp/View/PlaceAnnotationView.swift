//
//  PlaceAnnotationView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI
struct PlaceAnnotationView: View {
  @State private var showTitle = true
  @State private var sheet = false
  let prefectureName: String
  let citys: Array<String>
    
    
  var body: some View {
    VStack(spacing: 0) {
        Button(prefectureName) {
            sheet.toggle()
        }.sheet(isPresented: $sheet) {
            ReViewPage(prefectureName: prefectureName, citys:citys)
        }
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        .opacity(showTitle ? 0 : 1)
      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.blue)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.blue)
        .offset(x: 0, y: -5)
    }
    .onTapGesture {
      withAnimation(.easeInOut) {
        showTitle.toggle()
      }
    }
  }
}
