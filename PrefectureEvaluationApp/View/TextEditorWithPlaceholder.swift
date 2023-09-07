//
//  SwiftUIView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/15.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
     @Binding var text: String
     let hintText:String
    @FocusState var isKeybordOn: Bool
     var body: some View {
         ZStack(alignment: .leading) {
             if text.isEmpty {
                VStack {
                     Text(hintText)
                         .padding(.top, 17)
                         .padding(.leading, 30)
                         .opacity(0.6)
                     Spacer()
                 }
             }
             
             VStack {
                 TextEditor(text: $text).padding(.leading,15).padding(.trailing, 15)
                     .frame(minHeight: 150, maxHeight: 300)
                     .focused($isKeybordOn)
                     .scrollContentBackground(.hidden)
                     .background(.white, in: RoundedRectangle(cornerRadius: 30.0))
                     .opacity(text.isEmpty ? 0.85 : 1)
                 Spacer()
             }.padding(.all, 10)
         }
     }
 }
