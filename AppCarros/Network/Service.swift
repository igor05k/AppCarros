//
//  Service.swift
//  AppCarros
//
//  Created by Igor Fernandes on 17/11/22.
//

import Foundation

class Service {
    static func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://carros-springboot.herokuapp.com/api/v2/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        } catch {
            print(error)
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode(User.self, from: data)
                    Keychain.standard.save(json, service: "token", account: "app")
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    // https://carros-springboot.herokuapp.com/api/v2/carros
    
    static func getCarsWith(authorization token: String, completion: @escaping (Result<[CarInfo], Error>) -> Void) {
        guard let url = URL(string: "https://carros-springboot.herokuapp.com/api/v2/carros") else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode([CarInfo].self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
