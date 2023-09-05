//
//  MapViewPage.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import SwiftUI
import MapKit
import Dispatch

struct MapViewPage: View {
    @ObservedObject var mapViewModel = MapViewModel()
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapViewModel.region,
                showsUserLocation: true,
                annotationItems: mapViewModel.spotList,
                annotationContent: { spot in
                MapAnnotation(coordinate: spot.coordinate) {
                    PlaceAnnotationView(prefectureName: spot.prefectureName,citys: spot.citys)
                }
            })
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                SerchView(searchText: $mapViewModel.searchText,onSubmit: {
                    mapViewModel.geocode(addressKey: mapViewModel.searchText, completionHandler: { coordinate in
                        if(coordinate != nil){
                            let center =  CLLocationCoordinate2D(
                                latitude: coordinate!.latitude, // 緯度
                                longitude: coordinate!.longitude // 経度
                            )
                            mapViewModel.region = MKCoordinateRegion(
                                center: center ,
                                latitudinalMeters: 100000.0,
                                longitudinalMeters: 100000.0
                            )
                        }
                    })
                })
                Spacer()
            }.onAppear {
                mapViewModel.reloadRegion()
            }
        }
    }
    
    struct MapViewPage_Previews: PreviewProvider {
        static var previews: some View {
            MapViewPage().environmentObject(CityCommentPostViewModel())
        }
    }
}
