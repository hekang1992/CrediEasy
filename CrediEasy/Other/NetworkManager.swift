//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import Combine
import Alamofire
import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case serverError(String)
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let baseURL = "http://47.84.60.25:8585/Flaxman"
    
    func get(
        path: String,
        parameters: [String: Any]? = nil
    ) -> AnyPublisher<BaseModel, NetworkError> {
        let url = baseURL + path
        let para = APIQueryBuilder.getPera()
        let apiUrl = URLQueryBuilder.appendingQueryParameters(to: url, parameters: para) ?? ""
        return AF.request(apiUrl, method: .get, parameters: parameters)
            .publishDecodable(type: BaseModel.self)
            .value()
            .mapError { .serverError($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
    
    func postJson(
        path: String,
        parameters: [String: Any]
    ) -> AnyPublisher<BaseModel, NetworkError> {
        let url = baseURL + path
        let para = APIQueryBuilder.getPera()
        let apiUrl = URLQueryBuilder.appendingQueryParameters(to: url, parameters: para) ?? ""
        return AF.request(apiUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json"])
        .publishDecodable(type: BaseModel.self)
        .value()
        .mapError { .serverError($0.localizedDescription) }
        .eraseToAnyPublisher()
    }
    
    func postForm(
        path: String,
        parameters: [String: Any]
    ) -> AnyPublisher<BaseModel, NetworkError> {
        let url = baseURL + path
        let para = APIQueryBuilder.getPera()
        let apiUrl = URLQueryBuilder.appendingQueryParameters(to: url, parameters: para) ?? ""
        return Future<BaseModel, NetworkError> { promise in
            AF.upload(multipartFormData: { formData in
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: .utf8) {
                        formData.append(data, withName: key)
                    }
                }
            }, to: apiUrl)
            .responseDecodable(of: BaseModel.self) { response in
                switch response.result {
                case .success(let model):
                    promise(.success(model))
                case .failure(let error):
                    promise(.failure(.serverError(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func uploadImage(
        path: String,
        parameters: [String: Any]? = nil,
        image: UIImage,
        imageName: String = "perisinuitis"
    ) -> AnyPublisher<BaseModel, NetworkError> {
        let url = baseURL + path
        let para = APIQueryBuilder.getPera()
        let apiUrl = URLQueryBuilder.appendingQueryParameters(to: url, parameters: para) ?? ""
        return Future<BaseModel, NetworkError> { promise in
            AF.upload(multipartFormData: { formData in
                if let params = parameters {
                    for (key, value) in params {
                        if let data = "\(value)".data(using: .utf8) {
                            formData.append(data, withName: key)
                        }
                    }
                }
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    formData.append(imageData,
                                    withName: imageName,
                                    fileName: "\(UUID().uuidString).jpg",
                                    mimeType: "image/jpeg")
                }
            }, to: apiUrl)
            .responseDecodable(of: BaseModel.self) { response in
                switch response.result {
                case .success(let model):
                    promise(.success(model))
                case .failure(let error):
                    promise(.failure(.serverError(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

struct URLQueryBuilder {
    static func appendingQueryParameters(to urlString: String,
                                         parameters: [String: String]) -> String? {
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        
        let existingQueryItems = components.queryItems ?? []
        let newQueryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        components.queryItems = existingQueryItems + newQueryItems
        
        return components.url?.absoluteString
    }
}

struct APIQueryBuilder {
    static func getPera() -> [String: String] {
        let dict = ["metacoracoid": "1.0.0",
                    "recamera": UIDevice.current.name,
                    "turnscrew": IDFVManager.shared.getPersistentIDFV() ?? "",
                    "poxvirus": UIDevice.current.systemVersion,
                    "hullabaloos": AuthManager.shared.getAuthToken() ?? "",
                    "sanitised": IDFAManager.getIDFA() ?? ""]
        return dict
    }
}
