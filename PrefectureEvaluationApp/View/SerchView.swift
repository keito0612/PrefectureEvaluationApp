//
//  SerchView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI

struct SerchView: View {
    @Binding var searchText: String
    let onSubmit: ()-> Void
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("検索", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit() {
                    onSubmit()
                }
            if !searchText.isEmpty {
                Button {
                    searchText.removeAll()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 6)
            }
        }
        .padding()
    }
}
