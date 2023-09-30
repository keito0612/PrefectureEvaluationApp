//
//  ProfileSettingViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/09/06.
//

import SwiftUI
import Kingfisher

struct ProfileSettingViewPage: View {
    let user:User
    @Binding  var path:[Int]
    @Binding  var num:Int
    @State var isPresent:Bool = false
    @StateObject var  model :ProfileSettingViewModel = ProfileSettingViewModel(photo: "")
    init(user:User,path:Binding<[Int]>, num:Binding <Int>){
        self.user  = user
        _model = .init(wrappedValue: .init(photo: user.photo!))
        self._path = path
        self._num = num
    }
    
    var body: some View {
        ZStack{
            List{
                ImageTileView(photo: model.photo!, path: $path, num: $num, isPresent: $isPresent, showingImagePicker: $model.showingImagePicker)
                NameTileView(name: user.name!,path: $path, num: $num, isPresent: $isPresent)
            }.navigationBarTitle("設定" , displayMode: .inline)
                .navigationDestination(isPresented: $isPresent) {
                    NameEditViewPage(path: $path, num: $num, name: user.name!)}
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            num -= 1
                            path.remove(at: num)
                        }) {
                        }
                    }
                }.photosPicker(isPresented: $model.showingImagePicker   ,selection: $model.selectedImage)
            if(model.profileSettingViewModelState == .isLoading){
                LoadingView(scaleEffect: 3)
            }
        }
      
    }
}

struct ImageTileView: View{
    let photo:String
    @Binding var path:[Int]
    @Binding var num:Int
    @Binding var isPresent: Bool
    @Binding var showingImagePicker:Bool
    var body: some View{
        HStack{
            Text("写真")
            Spacer()
            if(photo.isEmpty){
                Circle()
                    .fill(Color.gray)
            }else{
               KFImage(URL(string: photo))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(20)
            }
        }.frame(height: 50).onTapGesture {
            showingImagePicker = true
        }
    }
}


struct NameTileView: View{
    let name:String
    @Binding var path:[Int]
    @Binding var num:Int
    @Binding var isPresent: Bool
    var body: some View{
            HStack{
                Text("名前")
                Text(name).frame(maxWidth: .infinity,alignment: .
                                 trailing)
            } .contentShape(Rectangle()).onTapGesture {
                isPresent = true
                num += 1
                path.append(num)
                
            }.frame(height: 50)
        }
}
