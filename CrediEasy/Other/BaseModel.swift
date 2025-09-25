//
//  BaseModel.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/9.
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
    var revolutionised: [revolutionisedModel]?
    var roosing: [revolutionisedModel]?
    var melena: melenaModel?
    var toothful: [toothfulModel]?
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
    var banshees: String?
    var buoyed: [buoyedModel]?
    var opinicuses: String?
    var saxcornet: String?
    var concentre: String?
    var consuelo: String?
    var crackrope: String?
    var arched: String?
    var refool: String?
    var nonmarveling: String?
    var pompilidae: String?
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
    var saxcornet : String?
}

class felicianaModel: Codable {
    var saxcornet: String?
    var symbol: String?
    var foliature: Int?
    var crackrope: String?
    var lutes: lutesModel?
    var consuelo: String?
    var geet: String?
    var hippolith: Int?
    var tablelike: String?
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
    var roguy: String?
}

class foxtrotModel: Codable {
    var ideist: Int?
    var agynic: String?
    var roguy: String?
}

class kinematographModel: Codable {
    var epees: String?
    var spermatogonia: String?
    var roguy: String?
}

class interspicularModel: Codable {
    var hydrophoria: String?
    var identifiable: String?
    var larcenable: String?
}

class revolutionisedModel: Codable {
    var estoppels: String?
    var larcenable: String?
    var ranivorous: String?
    var spermatogonia: String?
    var scalping: [scalpingModel]?
    var undivergent: Int?
    var whens: String?
    var derailer: Int?
    var freit: String?
    var geigy: String?
    var semaphorically: String?
    var carmela: String?
    var banshees: String?

    enum CodingKeys: String, CodingKey {
        case estoppels, larcenable, ranivorous, spermatogonia, scalping, undivergent, whens, derailer, freit, geigy, semaphorically, carmela, banshees
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        estoppels = try? container.decode(String.self, forKey: .estoppels)
        larcenable = try? container.decode(String.self, forKey: .larcenable)
        ranivorous = try? container.decode(String.self, forKey: .ranivorous)
        spermatogonia = try? container.decode(String.self, forKey: .spermatogonia)
        scalping = try? container.decode([scalpingModel].self, forKey: .scalping)
        undivergent = try? container.decode(Int.self, forKey: .undivergent)
        whens = try? container.decode(String.self, forKey: .whens)
        derailer = try? container.decode(Int.self, forKey: .derailer)
        freit = try? container.decode(String.self, forKey: .freit)
        geigy = try? container.decode(String.self, forKey: .geigy)
        banshees = try? container.decode(String.self, forKey: .banshees)
        semaphorically = try? container.decode(String.self, forKey: .semaphorically)
        
        if let intValue = try? container.decode(Int.self, forKey: .carmela) {
            carmela = String(intValue)
        } else {
            carmela = try? container.decode(String.self, forKey: .carmela)
        }
    }
}

class scalpingModel: Codable {
    var banshees: String?
    var derailer: Int?
}

class melenaModel: Codable {
    var spermatogonia: String?
    var unminimized: String?
}

class toothfulModel: Codable {
    var approximatively: String?
    var pashim: String?
    var circumduct: String?
    var retier: String?
    var roguy: String?
    var skyhook: String?
}
