//
//  NetworkManager.swift
//  WeatherSample
//
//  Created by Mario Arambula on 8/11/19.
//  Copyright © 2019 Mario Arambula. All rights reserved.
//

import Foundation
import UIKit

protocol Serializable: Codable {
    
    func serialize() -> Data?
}

class NetworkManager: NSObject {
    
    static let group = DispatchGroup()
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    enum HttpMethod: String {
        
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    public static let shared = NetworkManager()
    
    private(set) var fetchSession: URLSession = URLSession(configuration: .default)
    
    func performRequest<T: Codable>(urlString: String,
                                    method: HttpMethod = .GET,
                                    paidLoad: Data?,
                                    multiFormData: Bool = false,
                                    groupedTask: Bool = false,
                                    completion: @escaping (Result<T, GenericError>)->()) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(.failure(.init(type: .netWork)))
            return
        }
        
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.init(type: .unexpected)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = paidLoad
        request.timeoutInterval = 15
        
        if multiFormData {
            
            request.setValue(String(paidLoad?.count ?? 0), forHTTPHeaderField: "Content-Length")
            request.httpShouldHandleCookies = false
            request.setValue("multipart/form-data; boundary=" + multiPartFormDataBoundary, forHTTPHeaderField: "Content-Type")
        }
        
        groupedTask ? NetworkManager.group.enter() : nil
        
        fetchSession.dataTask(with: request, completionHandler: { data, response, err in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) || (400...499).contains(httpResponse.statusCode)
                
                else {
                    completion(.failure(.init(type: .unexpected)))
                    groupedTask ? NetworkManager.group.leave() : nil
                    return
            }
            
            guard let data = data else {
                completion(.failure(.init(type: .unexpected)))
                groupedTask ? NetworkManager.group.leave() : nil
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(obj))
                groupedTask ? NetworkManager.group.leave() : nil
            }
                
            catch let jsonErr {
                
                print("Error decoding json: ", jsonErr)
                completion(.failure(.init(type: .jsonDecoding)))
                groupedTask ? NetworkManager.group.leave() : nil
                return
            }
            
        }).resume()
    }
    
    
    func cancelAllRequests() {
        
        fetchSession.getTasksWithCompletionHandler({ dataTasks, _, _ in
            dataTasks.forEach({ $0.cancel() })
        })
        
        print("*** All Network Request Canceled ***")
    }
}


extension Serializable {
    
    func serialize() -> Data? {
        
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}


// MARK: - multipart / form-data


extension NetworkManager {
    
    func getDataAsFormData(imgData: Data, fileName: String, params: [String: String]? = nil) -> Data? {
        
        let boundary = multiPartFormDataBoundary
        var body = Data()
        
        if let params = params {
            for (key, value) in params {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\r\n")
        body.append("Content-Type: image/jpg\r\n\r\n")
        body.append(imgData)
        body.append("\r\n")
        
        body.append("--\(boundary)--\r\n")
        return body
    }
}

