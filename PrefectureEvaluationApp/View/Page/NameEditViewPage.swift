//
//  NameSettingViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/20.
//

import SwiftUI

struct NameEditViewPage: View {
    @Binding  var path:[Int]
    @Binding  var num:Int
   @Environment(\.dismiss) var dismiss
   @StateObject var model:NameEditViewModel = NameEditViewModel(name: "")
    init(path:Binding<[Int]>, num:Binding <Int> ,name:String){
        _model = .init(wrappedValue: .init(name: name))
        self._path = path
        self._num = num
    }
    var body: some View {
            VStack{
                NameTextField(nameText:  $model.name)
                EditButton(model: model)
                Spacer()
            }.navigationBarTitle("名前編集").navigationBarTitleDisplayMode(.inline).toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        num -= 1
                        path.remove(at: num)
                    }) {
                    }
                }
            }  .alert(isPresented: $model.isShowAlert) {
                switch model.alertType {
                case .warning:
                    return Alert(title: Text(model.alertTitle),
                                 message:  Text(model.alertMessage),
                                 dismissButton: .default(Text("OK")){
                        dismiss()
                        num = 0
                        path.removeAll()
                       
                    })
                case .error:
                    return Alert(title: Text(model.alertTitle),message: Text(model.alertMessage),
                               dismissButton: .default(Text("OK")))
                }
              }
        }
}


private struct NameTextField :View {
    @Binding var nameText:String
    var body: some View{
        TextField("あなたの名前", text: $nameText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 5)
            )
            .padding()
    }
}



private struct EditButton : View{
    @ObservedObject var model :NameEditViewModel
    var body: some View{
        Button( action: {
            Task{
                try await model.updateName()
            }
        }){
            Text("編集").fontWeight(.semibold)
                .frame(width: 160, height: 48)
                .foregroundColor(Color(.white))
                .background(Color(.blue))
                .cornerRadius(24)
        }
    }
}

