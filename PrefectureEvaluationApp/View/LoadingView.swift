//
//  LoadingView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/11.
//

import SwiftUI

struct LoadingView: View {
    private let scaleEffect: CGFloat
    init(scaleEffect: CGFloat) {
        self.scaleEffect = scaleEffect
    }
    var body: some View {
        VStack {
            ProgressView() .progressViewStyle(.circular)
                .scaleEffect(scaleEffect)
                .frame(width: scaleEffect * 20, height: scaleEffect * 20)
            Text("読み込み中")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.gray.opacity(0.5))
        

    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(scaleEffect: 3)
    }
}
