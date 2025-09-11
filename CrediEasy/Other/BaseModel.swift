//
//  BaseModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

class BaseModel: Codable {
    var ande: andeModel?
    var hypsodonty: String?
    var larcenable: String?
}

class andeModel: Codable {
    var hematopoietically: String?
    var percents: Int?
    var fifteenths: fifteenthsModel?
    var hullabaloos: String?
    var dioon: String?
    var userInfo: userInfoModel?
    var buoyed: [buoyedModel]?
    
}

class fifteenthsModel: Codable {
    var abidances: String?
    var commonalty: String?
    var moonblink: String?
    var unknits: String?
}

class userInfoModel: Codable {
    var userphone: String?
}

class buoyedModel: Codable {
    var roguy: String?
    var sauch: String?
    var spermatogonia: String?
    var derailer: String?
    var disgaveled: [disgaveledModel]?
}

class disgaveledModel: Codable {
    var arrode: String?
    var consuelo: String?
    var crackrope: String?
    var fleuret: String?
    var photoelectron: String?
    var unresourcefulness: String?
    var amps: Int?
}
