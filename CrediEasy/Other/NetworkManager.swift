//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import Foundation
import Alamofire
import Combine
import UIKit

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
        
        return AF.request(url, method: .get, parameters: parameters)
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
        
        return AF.request(url,
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
        
        return Future<BaseModel, NetworkError> { promise in
            AF.upload(multipartFormData: { formData in
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: .utf8) {
                        formData.append(data, withName: key)
                    }
                }
            }, to: url)
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
        
        return Future<BaseModel, NetworkError> { promise in
            AF.upload(multipartFormData: { formData in
                if let params = parameters {
                    for (key, value) in params {
                        if let data = "\(value)".data(using: .utf8) {
                            formData.append(data, withName: key)
                        }
                    }
                }
                // 图片文件
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    formData.append(imageData,
                                    withName: imageName,
                                    fileName: "\(UUID().uuidString).jpg",
                                    mimeType: "image/jpeg")
                }
            }, to: url)
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
