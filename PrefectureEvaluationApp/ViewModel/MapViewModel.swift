//
//  MapMode.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

enum MapViewState {
    case isLoading
    case error(String)
    case data
}


class MapViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isSearchBarFocused: Bool = false
    @Published var searchText: String = ""
    @Published var searchFieldIsFocused: Bool = false
    @Published var region =  MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.68944,
            longitude: 139.69167) ,
        latitudinalMeters: 1000000.0,
        longitudinalMeters: 1000000.0
    )
   @Published var mapViewState = MapViewState.isLoading
    let spotList :Array<Spot> = [Spot(prefectureName: "北海道", latitude: 43.0352, longitude: 141.2172, citys:["札幌市", "旭川市", "函館市", "小樽市", "室蘭市", "釧路市", "帯広市", "北見市", "夕張市", "岩見沢市", "網走市", "留萌市", "苫小牧市","稚内市", "美唄市","芦別市","江別市","赤平市","紋別市","士別市","名寄市","三笠市" ,"根室市", "千歳市","滝川市","砂川市","歌志内市","深川市","富良野市","登別市","恵庭市","伊達市","北広島市","石狩市","北杜市"]),
                                 Spot(prefectureName: "青森県", latitude: 40.4928, longitude: 140.4424, citys:[ "青森市", "弘前市", "八戸市", "黒石市", "十和田市", "三沢市", "むつ市", "つがる市", "平川市", "大鰐町", "東津軽郡", "西津軽郡", "南津軽郡", "中津軽郡", "上北郡", "下北郡"]),
                                 Spot(prefectureName: "岩手県", latitude: 39.4213, longitude: 141.091, citys:  ["盛岡市", "宮古市", "大船渡市", "花巻市", "北上市", "水沢市", "奥州市", "一関市", "遠野市", "釜石市", "二戸市", "八幡平市", "岩手郡", "奥州市"]),
                                      Spot(prefectureName: "宮城県", latitude: 38.1608, longitude: 140.922, citys:  ["仙台市", "石巻市", "塩竈市", "気仙沼市", "白石市", "名取市", "角田市", "多賀城市", "岩沼市", "登米市", "栗原市", "東松島市"]),
                                 Spot(prefectureName: "秋田県", latitude: 39.4307, longitude: 140.0609,citys:["秋田市", "大館市", "能代市", "湯沢市", "横手市", "由利本荘市", "大仙市", "潟上市", "男鹿市", "にかほ市", "山本郡", "仙北郡", "南秋田郡", "北秋田郡"]),
                                 Spot(prefectureName: "山形県", latitude: 38.1426, longitude: 140.2148,citys: ["山形市", "米沢市", "鶴岡市", "酒田市", "新庄市", "寒河江市", "上山市", "天童市", "東根市", "尾花沢市"]),
                                 Spot(prefectureName: "福島県", latitude: 37.45, longitude: 140.2804,citys: ["福島市", "郡山市", "いわき市", "会津若松市", "水戸市", "白河市", "須賀川市", "喜多方市", "相馬市", "二本松市", "南相馬市", "伊達市"]),
                                 Spot(prefectureName: "茨城県", latitude: 36.203, longitude: 140.2649,citys: ["水戸市", "つくば市","日立市", "土浦市", "古河市", "水戸市", "つくば市", "ひたちなか市", "土浦市", "古河市", "石岡市", "結城市", "龍ケ崎市", "取手市", "牛久市", "つくばみらい市", "茨城町", "小美玉市", "行方市", "鉾田市", "潮来市"]),
                                 Spot(prefectureName: "栃木県", latitude: 36.3357, longitude: 139.5301,citys: ["宇都宮市", "足利市", "佐野市", "鹿沼市", "日光市", "小山市", "栃木市", "下野市", "真岡市", "矢板市", "那須塩原市", "芳賀郡", "さくら市"]),
                                 Spot(prefectureName: "群馬県", latitude: 36.2328, longitude: 139.0339,citys:  ["前橋市", "高崎市", "桐生市", "伊勢崎市", "太田市", "沼田市", "館林市", "渋川市", "藤岡市", "富岡市", "安中市", "みどり市"]),
                                 Spot(prefectureName: "埼玉県", latitude: 35.6917, longitude: 139.6917,citys: ["埼玉市", "川越市", "熊谷市", "川口市", "所沢市", "さいたま市", "川越市", "熊谷市", "川口市", "所沢市", "越谷市", "草加市", "春日部市","久喜市","北本市","八潮市","富士見市","三郷市","蓮田市","蓮田市","坂戸市","幸手市","鶴ヶ島市","日高市","吉川市","ふじみ野市","白岡市"]),
                                 Spot(prefectureName: "千葉県", latitude: 35.6895, longitude: 140.1272,citys: ["千葉市","銚子市","市川市","船橋市","館山市","木更津市","松戸市","野田市","茂原市","成田市","佐倉市","東金市","旭市","習志野市","柏市","勝浦市","市原市","流山市","八千代市","我孫子市","鴨川市","鎌ヶ谷市","君津市","富津市","浦安市","四街道市","袖ケ浦市","八街市","印西市","白井市","富里市","南房総市","匝瑳市","香取市","山武市","いすみ市","大網白里市"]),
                                 Spot(prefectureName: "東京都", latitude: 35.6895, longitude: 139.6917,citys: ["八王子市","立川市","武蔵野市","三鷹市","青梅市","府中市","昭島市","調布市","町田市","小金井市","小平市","日野市","東村山市","国分寺市","国立市","福生市","狛江市","東大和市","清瀬市","東久留米市","武蔵村山市","多摩市","稲城市","羽村市","あきる野市","西東京市"]),
                                 Spot(prefectureName: "神奈川県", latitude: 35.6917, longitude: 139.6917,citys: ["横浜市","川崎市","相模原市","横須賀市",
                                       "鎌倉市","藤沢市","小田原市","茅ヶ崎市","逗子市","三浦市","秦野市","厚木市","大和市","伊勢原市","海老名市","座間市","南足柄市","綾瀬市"]),
                                 Spot(prefectureName: "新潟県", latitude: 37.7569, longitude: 139.0625,citys: ["追加"]),
                                 Spot(prefectureName: "富山県", latitude: 36.6969, longitude: 137.2778,citys: []),
                                 Spot(prefectureName: "石川県", latitude: 36.2028, longitude: 136.75,citys: []),
                                 Spot(prefectureName: "福井県", latitude: 36.0667, longitude: 136.25,citys: []),
                                 Spot(prefectureName: "山梨県", latitude: 35.6917, longitude: 138.5625,citys: []),
                                 Spot(prefectureName: "長野県", latitude: 36.6969, longitude: 138.2778,citys: []),
                                 Spot(prefectureName: "岐阜県", latitude: 35.3056, longitude: 136.8889,citys: []),
                                 Spot(prefectureName: "静岡県", latitude: 34.6944, longitude: 138.3611,citys: []),
                                 Spot(prefectureName: "愛知県", latitude: 35.1667, longitude: 136.9167,citys: []),
                                 Spot(prefectureName: "三重県", latitude: 34.6944, longitude: 136.3611,citys: []),
                                 Spot(prefectureName: "滋賀県", latitude: 34.9722, longitude: 135.8056,citys: []),
                                 Spot(prefectureName: "京都府", latitude: 35.0667, longitude: 135.75,citys: []),
                                 Spot(prefectureName: "大阪府", latitude: 34.6944, longitude: 135.5,citys: []),
                                 Spot(prefectureName: "兵庫県", latitude: 34.6944, longitude: 135.1667,citys: []),
                                Spot(prefectureName: "奈良県", latitude: 34.6944, longitude: 135.1667,citys: []),
                                Spot(prefectureName: "和歌山県", latitude: 34.1667, longitude: 135.1667,citys: []),
                                Spot(prefectureName: "鳥取県", latitude: 35.1667, longitude: 134.1667,citys: []),
                                Spot(prefectureName: "島根県", latitude: 35.6944, longitude: 133.3611,citys: []),
                                 Spot(prefectureName: "岡山県", latitude: 34.3056, longitude: 133.8056,citys: []),
                                Spot(prefectureName: "広島県", latitude: 34.0667, longitude: 132.4167,citys: []),
                                    Spot(prefectureName: "山口県", latitude: 34.0667, longitude: 131.6667,citys: ["下関市","宇部市","山口市","萩市","防府市","下松市","岩国市","光市","長門市","柳井市","美祢市","周南市","山陽小野田市"]),
                                    Spot(prefectureName: "徳島県", latitude: 34.3056, longitude: 134.6944,citys: ["徳島市","鳴門市","小松島市","阿南市","吉野川市","阿波市","美馬市","三次市"]),
                                    Spot(prefectureName: "香川県", latitude: 34.3056, longitude: 134.0667,citys: ["高松市","丸亀市","坂出市","善通寺市","観音寺市","さぬき市","東香川市","三豊市"]),
                                 Spot(prefectureName: "愛媛県", latitude: 33.8056, longitude: 133.3056,citys: ["松島市","今治市","宇和島市","八幡浜市","新居浜市","西条市","大洲市","伊予市","四国中央市","西洋市","東温市"]),
                                    Spot(prefectureName: "高知県", latitude: 33.5, longitude: 133.5,citys: ["高知県","室戸市","安芸市","南国市","土佐市","須崎市","宿毛市","宿毛市","土佐清水市","四万十市","香南市","香美市"]),
                                    Spot(prefectureName: "福岡県", latitude: 33.5, longitude: 130.4167,citys: ["北九州市","福岡市","大牟田市","久留米市"]),
                                    Spot(prefectureName: "佐賀県", latitude: 33.3056, longitude: 130.25,citys: [
                                        "佐賀市","唐津市","鳥栖市","多久市","伊万里市","武雄市","鹿島市","小城市","嬉野市","神埼市"
                                    ]),
                                    Spot(prefectureName: "長崎県", latitude: 33.0667, longitude: 129.6667,citys: ["長崎市","佐世保市","島原市","諫早市","大村市","平戸市","松浦市","津島市","壱岐市","五島市","西海市","雲仙市","南島原市"]),
                                    Spot(prefectureName: "熊本県", latitude: 32.75, longitude: 130.5,citys: [
                                        "熊本市","八代市","人吉市","荒尾市","水俣市","玉名市","山鹿市","菊池市","宇土市","上天草市","宇城市","阿蘇市","天草市","合志市"
                                    ]),
                                    Spot(prefectureName: "大分県", latitude: 33.5, longitude: 131.0,citys: ["大分市","別府市","中津市","日田市","佐伯市","臼杵市","佐伯市","津久見市","竹田市","豊後高田市","杵築市","宇佐市","豊後大野市","由布市","国東市"]),
                                 Spot(prefectureName: "宮崎県", latitude: 32.75, longitude: 131.3333,citys: ["宮崎市","都城市","延岡市","日南市","小林市","日向市","串間市","西都市","えびの市"]),
                                    Spot(prefectureName: "鹿児島県", latitude: 32.75, longitude: 130.5,citys: ["鹿児島市","鹿屋市","枕崎市","阿久根市","出水市","指宿市","西之表市","垂水市","薩摩川内市","日置市","曽於市","霧島市","いちき串木野市","南さつま市","志布志市","奄美市","南九州市","伊佐市","姶良市"]),
                                      Spot(prefectureName: "沖縄県", latitude: 26.2172, longitude: 127.6828,citys: ["那覇市","宜野湾市","石垣市","浦添市","名護市","糸満市","沖縄市","豊見城市","うるま市","宮古島市","南城市"])
                                      ]
    
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    override init() {
        super.init()
            self.manager.delegate = self // 自身をデリゲートプロパティに設定
            self.manager.requestWhenInUseAuthorization() // 位置情報を利用許可をリクエスト
            self.manager.desiredAccuracy = kCLLocationAccuracyBest// 最高精度の位置情報を要求
            self.manager.distanceFilter = 3.0 // 更新距離(m)
            self.manager.startUpdatingLocation()
            self.locationManagerDidChangeAuthorization(manager)
        
    }
    
    // 位置情報が拒否された場合に初期表示位置を構築：東京スカイツリーの場所
       func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
           let guarded = manager.authorizationStatus.rawValue
           if guarded == 2 {
               let center = CLLocationCoordinate2D(
                   latitude: 35.709152712026265,
                   longitude: 139.80771829999996)
               
                   region = MKCoordinateRegion(
                   center: center,
                   latitudinalMeters: 1000.0,
                   longitudinalMeters: 1000.0
               )
           }
       }
    
    // ジオコーディング
       func geocode(addressKey:String,completionHandler: @escaping (CLLocationCoordinate2D?) -> Void){
           self.mapViewState = .isLoading
           geocoder.geocodeAddressString(addressKey) { (placemarks, error) in
               guard let unwrapPlacemark = placemarks else {
                   // ジオコーディングできない文字列の場合
                   DispatchQueue.main.async {
                       completionHandler(nil)
                   }
                   return
               }
               let location  = unwrapPlacemark.first!.location!
               // 非同期処理で実行
               DispatchQueue.main.async {
                   completionHandler(location.coordinate)
               }
           }
           self.mapViewState = .data
       }
    
    func reloadRegion (){
        if let location = manager.location {
            let center = CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude)
            
                self.region = MKCoordinateRegion(
                center: center,
                latitudinalMeters: 1000.0,
                longitudinalMeters: 1000.0
            )
        }
    }
}
