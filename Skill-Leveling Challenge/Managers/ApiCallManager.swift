//
//  ApiCallManager.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 20-09-22.
//

import Foundation

enum ApiCallError: Error {
    case serverError(_ statusCode: Int)
    case internalError(_ statusCode: Int)
    case decodingError
    
    var description: String {
        switch self {
        case .serverError(let statusCode):
            return "Server Error: \(statusCode)"
        case .internalError(let statusCode):
            return "Internal Error: \(statusCode)"
        case.decodingError:
            return "Decoding of JSON data"
        }
    }
}

class ApiCallManager {
    let baseUrl: String = "https://api.mercadolibre.com/"
    private var accessToken: String = "ACCESS TOKEN"
    
    static let shared = ApiCallManager()
    
    private init() {}
    
    func buildSecureRequest(_ url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(ApiCallManager.shared.accessToken)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func call<DataModel: Decodable>(_ request: URLRequest, completion: @escaping ((Result<DataModel, ApiCallError>) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                switch httpResponse.statusCode {
                    case (400...499):
                    completion(.failure(ApiCallError.serverError(httpResponse.statusCode)))
                    print("Server Error: \(httpResponse.statusCode)")
                    default:
                    completion(.failure(ApiCallError.internalError(httpResponse.statusCode)))
                    print("Internal Error: \(httpResponse.statusCode)")
                }
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ApiCallError.decodingError))
            }
        }
        task.resume()
    }
    
    func fetchCategory(_ searchParameter: String, callback: @escaping (Result<Categories, ApiCallError>) -> Void) {
        let absoluteString = "\(baseUrl)sites/MLC/domain_discovery/search?limit=1&q=\(searchParameter)"
        
        guard let url = URL(string: absoluteString) else { return }
        
        call(self.buildSecureRequest(url), completion: callback)
     
    }
    
    func fetchTopItemsIds(_ category: Category, callback: @escaping (Result<HighlightQuery, ApiCallError>) -> Void) {
        let absoluteString = "\(self.baseUrl)highlights/MLC/category/\(category.category_id)"
        
        guard let url = URL(string: absoluteString) else { return }
        
        call(self.buildSecureRequest(url), completion: callback)

    }
    
    func fetchItemsDetailsFor(_ highlightQuery: HighlightQuery, callback: @escaping (Result<MultigetQuery, ApiCallError>) -> Void) {
        
        var idsString = ""
        
        highlightQuery.content.forEach { highlightQueryItem in
            if highlightQueryItem.type == "ITEM" {
                idsString.append("\(highlightQueryItem.id),")
            }
        }
        
        let absoluteString = "\(self.baseUrl)items?ids=\(idsString)"
        
        guard let url = URL(string: absoluteString) else { return }
        
        call(self.buildSecureRequest(url), completion: callback)

    }
    
    func fetchItemsDetailsFor(_ idList: [String], callback: @escaping (Result<MultigetQuery, ApiCallError>) -> Void) {
        let absoluteString = "\(self.baseUrl)items?ids=\(idList.joined(separator: ","))"
        print(absoluteString)
        
        guard let url = URL(string: absoluteString) else { return }

        call(self.buildSecureRequest(url), completion: callback)

    }
    
    func fetchDescription(_ itemId: String, callback: @escaping (Result<Description, ApiCallError>) -> Void) {
        let absoluteString = "\(baseUrl)/items/\(itemId)/description"
        
        guard let url = URL(string: absoluteString) else { return }

        call(self.buildSecureRequest(url), completion: callback)

    }
    
}
