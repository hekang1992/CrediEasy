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
    var roguy: String? ///schemurl
    var feliciana: felicianaModel?
    var beakful: [beakfulModel]?
    var foxtrot: foxtrotModel?
    var helotry: foxtrotModel?
    var prefelic: [String]?
    var evaporize: [String]?
    var kinematograph: kinematographModel?
    var interspicular: [interspicularModel]?
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
    var threeDes: String?
}

class felicianaModel: Codable {
    var saxcornet: String?
    var symbol: String?
    var foliature: Int?
    var crackrope: String?
    var lutes: lutesModel?
    var consuelo: String?
}

class lutesModel: Codable {
    var nickled: nickledModel?
    var sunned: nickledModel?
}

class nickledModel: Codable {
    var spermatogonia: String?
    var unrecreant: String?
}

class beakfulModel: Codable {
    var spermatogonia: String?
    var estoppels: String?
    var prelatish: String?
    var ideist: Int?
    var epees: String?
}

class foxtrotModel: Codable {
    var ideist: Int?
    var agynic: String?
    var roguy: String?
}

class kinematographModel: Codable {
    var epees: String?
    var spermatogonia: String?
}

class interspicularModel: Codable {
    var hydrophoria: String?
    var identifiable: String?
    var larcenable: String?
}
