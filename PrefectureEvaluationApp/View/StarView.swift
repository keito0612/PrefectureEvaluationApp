//
//  Starr.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI

struct StarView: View {
    let star:Int?
    let size:Int?
    init(star: Int?, size: Int) {
        self.star = star
        self.size = size
    }
    var body: some View {
        HStack{
            ForEach(0..<5){ index in
                Image(systemName:  index < star! ?  "star.fill" : "star" ).foregroundColor(Color.yellow).font(.system(size: CGFloat(size!)))
            }
        }
    }
}

