//
//  PhotoScreenView.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/16.
//

import SwiftUI
import PhotosUI

struct PhotoPostScreenView: View {
    @ObservedObject  var cityCommentPostModel:CityCommentPostViewModel = CityCommentPostViewModel()
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @State var selectedItems = [PhotosPickerItem]()
    @Binding var selectedPhotos :[UIImage]
    var body: some View{
        LazyVGrid(columns: columns) {
            ForEach(0 ..< self.selectedPhotos.count , id: \.self){ index    in
                Image(uiImage: self.selectedPhotos[index]).resizable().padding([.leading,.trailing], 10).padding([.top, .bottom] , 10  ).frame( width: 150 ,height: 150)
            }
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 0) {
                Image(systemName: "camera").resizable().frame(width: 50,height: 50,alignment: .center).frame(width: 100,height: 100).background(Color.blue).foregroundColor(Color.white).clipShape(Circle()) .cornerRadius(16)
            }.onChange(of: selectedItems) { newItems in
                newItems.forEach { item in
                    Task {
                        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
                        guard let image = UIImage(data: data) else { return }
                        selectedPhotos.append(image)
                    }
                }
            }
            Spacer()
        }
        
    }
}

