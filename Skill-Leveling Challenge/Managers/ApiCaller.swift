//
//  ApiCaller.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 14-09-22.
//

import Foundation

class ApiCaller {
    let baseUrl: String = "https://api.mercadolibre.com/"
    private var accessToken: String = "APP_USR-7807578787136716-091916-dc16ae623fafecfb23fd09b0e0ca213d-61265024"
    
    static let shared = ApiCaller()
    
    private init() {}
    
    func buildSecureRequest(_ url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(ApiCaller.shared.accessToken)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func call<DataModel: Decodable>(_ request: URLRequest, completion: @escaping ((Result<DataModel, Error>) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchCategory(_ searchParameter: String, callback: @escaping (Result<Categories, Error>) -> Void) {
        let absoluteString = "\(baseUrl)sites/MLC/domain_discovery/search?limit=1&q=\(searchParameter)"
        
        guard let url = URL(string: absoluteString) else { return }
        
        call(buildSecureRequest(url), completion: callback)
    }
    
    func fetchItemsIds(_ searchParameter: String, callback: @escaping (Result<HighlightQuery, Error>) -> Void) {
        var selectedCategory: Category?
        
        fetchCategory(searchParameter) { result in
            switch result {
            case .success(let categories):
                selectedCategory = categories[0]
                
                guard let category = selectedCategory else { return }
                
                let absoluteString = "\(self.baseUrl)highlights/MLC/category/\(category.category_id)"
                
                guard let url = URL(string: absoluteString) else { return }
                
                self.call(self.buildSecureRequest(url), completion: callback)
                
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func fetchItemsDetails(_ searchParameter: String, callback: @escaping (Result<MultigetQuery, Error>) -> Void) {
        
        fetchItemsIds(searchParameter) { result in
            switch result {
            case .success(let highlightQuery):
                var idsString = ""
                highlightQuery.content.forEach { highlightQueryItem in
                    if highlightQueryItem.type == "ITEM" {
                        idsString.append("\(highlightQueryItem.id),")
                    }
                }
                
                let absoluteString = "\(self.baseUrl)items?ids=\(idsString)"
                
                guard let url = URL(string: absoluteString) else { return }
                
                self.call(self.buildSecureRequest(url), completion: callback)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDescription(_ itemId: String, callback: @escaping (Result<Description, Error>) -> Void) {
        let absoluteString = "\(baseUrl)/items/\(itemId)/description"
        
        guard let url = URL(string: absoluteString) else { return }
        
        call(buildSecureRequest(url), completion: callback)
    }
    
}
