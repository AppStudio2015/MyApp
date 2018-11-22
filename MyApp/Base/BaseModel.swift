//
//  BaseModel.swift
//  MyApp
//
//  Created by PandoraXY on 2018/10/15.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

public struct JsonData: Codable {
    var id: Int = 0
    var userId: String = ""
    var userImg: String = ""
    var userName: String = ""
    var groupId: String = ""
    var lon: Double = 0
    var lat: Double = 0
    var distance: Float = 0.0
    var distanceSurplus: Float = 0.0
    var surplusTime: Int = 0
    var speedMax: Float = 0.0
    var speed: Float = 0.0
    var creatTime: Int = 0
    var updateTime: Int = 0
    var city: String? = ""
    var origLon: Float = 0.0
    var origLat: Float = 0.0
    var isOver: Int = 0
    var tmcStatus: String = ""
}

public struct JsonStruct: Codable {
    var status: Int = 0
    var message: String = ""
    var data: [JsonData] = []
    var lon: Double = 0.0
    var lat: Double = 0.0
    var groupname: String = ""
}

class BaseModel: NSObject {

    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Setters and Getters
    
    // MARK: - Public Functions
    
    public func testCodable() -> Void {
        self.test()
    }
    
    // MARK: - Private Functions
    
    private func test() -> Void {
        //"https://httpbin.org/get"
        let urlString = "https://w.mapbar.com/api/3n1-wxgroup/wxGroup/searchTrip.json?groupid=13745671&isOver=0"
        let alamofire = SessionManager.default
        alamofire.request(urlString).response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                let decoder = JSONDecoder.init()
                guard let jsonStruct = try? decoder.decode(JsonStruct.self, from: data) else {
                    print("Decode Error")
                    return
                }
                let status = jsonStruct.status
                let message = jsonStruct.message
                let groupName = jsonStruct.groupname
                let lon = jsonStruct.lon
                let lat = jsonStruct.lat
                let jsonData = jsonStruct.data
                
                print("status=\(status)")
                print("message=\(message)")
                print("groupName=\(groupName)")
                print("lon=\(lon)")
                print("lat=\(lat)")
                
                print("Id=\(jsonData[0].id)")
                print("userId=\(jsonData[0].userId)")
                print("userImg=\(jsonData[0].userImg)")
                print("userName=\(jsonData[0].userName)")
                print("groupId=\(jsonData[0].groupId)")
                print("lon=\(jsonData[0].lon)")
                print("lat=\(jsonData[0].lat)")
                print("distance=\(jsonData[0].distance)")
                print("distanceSurplus=\(jsonData[0].distanceSurplus)")
                print("surplusTime=\(jsonData[0].surplusTime)")
                print("speedMax=\(jsonData[0].speedMax)")
                print("speed=\(jsonData[0].speed)")
                print("creatTime=\(jsonData[0].creatTime)")
                print("updateTime=\(jsonData[0].updateTime)")
                print("city=\(String(describing: jsonData[0].city))")
                print("origLon=\(jsonData[0].origLon)")
                print("origLat=\(jsonData[0].updateTime)")
                print("isOver=\(jsonData[0].isOver)")
                print("tmcStatus=\(jsonData[0].tmcStatus)")
            }
        }
    }
}


