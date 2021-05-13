//
//  NetworkManager.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/5/21.
//

import Foundation
import Alamofire

class NetworkManager {
    static let host: String = "https://culaundry.herokuapp.com/api/"
    
    static func createAllHalls(completion: @escaping (Bool) -> Void) {
        let endpoint = "\(host)create/halls/"
        AF.request(endpoint, method: .post, encoding: JSONEncoding.default).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let postResponse = try? jsonDecoder.decode(PostResponse.self, from: data) {
                    completion(postResponse.success)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createAllMachines(completion: @escaping (Bool) -> Void) {
        let endpoint = "\(host)create/machines/"
        AF.request(endpoint, method: .post, encoding: JSONEncoding.default).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let postResponse = try? jsonDecoder.decode(PostResponse.self, from: data) {
                    completion(postResponse.success)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func updateAllHalls(completion: @escaping (Bool) -> Void) {
        let endpoint = "\(host)update/halls/"
        AF.request(endpoint, method: .post, encoding: JSONEncoding.default).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let postResponse = try? jsonDecoder.decode(PostResponse.self, from: data) {
                    completion(postResponse.success)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func updateAllMachines(completion: @escaping (Bool) -> Void) {
        let endpoint = "\(host)update/machines/"
        AF.request(endpoint, method: .post, encoding: JSONEncoding.default).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let postResponse = try? jsonDecoder.decode(PostResponse.self, from: data) {
                    completion(postResponse.success)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getAllHalls(completion: @escaping ([LaundryRoomShort]) -> Void) {
        let endpoint = "\(host)halls/"
        AF.request(endpoint, method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let getResponse = try? jsonDecoder.decode(HallsResponse.self, from: data) {
                    completion(getResponse.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getHall(id: String, completion: @escaping (LaundryRoomLong) -> Void) {
        let endpoint = "\(host)hall/\(id)/"
        AF.request(endpoint, method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let getResponse = try? jsonDecoder.decode(HallResponse.self, from: data) {
                    completion(getResponse.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
