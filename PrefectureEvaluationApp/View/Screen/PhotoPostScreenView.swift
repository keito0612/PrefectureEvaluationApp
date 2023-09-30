//
//  PhotoScreenView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/16.
//

import SwiftUI
import PhotosUI

struct PhotoPostScreenView: View {
    @ObservedObject  var model:CityReviewPostViewModel 
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @State var selectedItems = [PhotosPickerItem]()
    
    var body: some View{
        LazyVGrid(columns: columns) {
            ForEach(0 ..< model.selectedPhotos.count , id: \.self){ index    in
                ZStack{
                    Image(uiImage: model.selectedPhotos[index]).resizable().padding([.leading,.trailing], 10).padding([.top, .bottom] , 10 ).frame( width: 150 ,height: 150)
                    Button(action: {
                        model.selectedPhotos.remove(at: index)
                    }){
                        Image(systemName: "xmark.circle").background(Color.white).foregroundColor(.blue).font(.system(size: 30, weight: .medium)).clipShape(Circle()).padding(.leading,100).padding(.bottom,100)
                    }
                }
            }
            if(model.selectedPhotos.count < 4 ){
                PhotosPicker(selection: $selectedItems, maxSelectionCount: 4) {
                    Image(systemName: "camera").resizable().frame(width: 50,height: 50,alignment: .center).frame(width: 100,height: 100).background(Color.blue).foregroundColor(Color.white).clipShape(Circle()) .cornerRadius(16)
                }.onChange(of: selectedItems) { newItems in
                    newItems.forEach { item in
                        Task {
                            guard let data = try? await item.loadTransferable(type: Data.self) else { return }
                            guard let image = UIImage(data: data) else { return }
                            if(model.selectedPhotos.count < 4 ){
                                model.selectedPhotos.append(image)
                            }
                        }
                    }
                }
            }else{
                Image(systemName: "camera").resizable().frame(width: 50,height: 50,alignment: .center).frame(width: 100,height: 100).background(Color.gray).foregroundColor(Color.white).clipShape(Circle()) .cornerRadius(16)
            }
            Spacer()
        }
        
    }
}

