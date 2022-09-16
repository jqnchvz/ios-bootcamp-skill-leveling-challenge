//
//  Networking.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 13-09-22.
//

import Foundation

protocol Networking {
  var baseUrl: String { get }
  
  func buildSecureRequest(_ url: URL) -> URLRequest
  func call<Model: Decodable>(_ request: URLRequest, completion: @escaping ((Result<Model, Error>) -> Void))
}

class RestClient: Networking {
  let baseUrl: String = "https://api.mercadolibre.com/"
  private var accessToken: String = "APP_USR-7807578787136716-091411-481ca2a4abc4a35e2f0e6a2a70d778c8-61265024"
  
  static let shared = RestClient()
  
  private init() {}
  
  
  // MARK: - Internal Functions
  
  func buildSecureRequest(_ url: URL) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("Bearer \(RestClient.shared.accessToken)", forHTTPHeaderField: "Authentication")
    
    return urlRequest
  }
  
  func call<DataModel: Decodable>(_ request: URLRequest, completion: @escaping ((Result<DataModel, Error>) -> Void)) {
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else { return }
      
      do {
        let result = try JSONDecoder().decode(DataModel.self, from: data)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  // MARK: - Private Functions
#warning("Pending")
  private func refreshToken() {}
}

protocol CategoryProvidable {
  func fetchCategory(_ searchParameter: String, callback: @escaping (Result<Category, Error>) -> Void)
}

struct CategoryProvider: CategoryProvidable {
  
  let networking: Networking
  
  init(networking: Networking = RestClient.shared) {
    self.networking = networking
  }

  func fetchCategory(_ searchParameter: String, callback: @escaping (Result<Category, Error>) -> Void) {
    let absoluteURLString = "\(networking.baseUrl)sites/MLA/domain_discovery/search?limit=1&q=\(searchParameter)"
    guard let url = URL(string: absoluteURLString) else { return }
    
    networking.call(networking.buildSecureRequest(url), completion: callback)
  }
}
