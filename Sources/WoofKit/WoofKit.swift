import Foundation
import UIKit

public class WoofKit {
    
    // MARK: - Properties -
    
    // MARK: - Private -
    
    private let decoder = JSONDecoder()
    
    // MARK: - Internal -
    
    // MARK: - Public -
    
    public typealias BreedsListResult = (Result<[Breed], Error>) -> Void
    public static let shared: WoofKit = WoofKit()
    
    // MARK: - Custom Types
    
    enum Endpoint {
        static let baseURL = URL(string: "https://dog.ceo/api/")!
        
        case list
        case images(ofBreed: Breed)
        
        var url: URL {
            switch self {
            case .list: return Endpoint.baseURL.appendingPathComponent("breeds/list/all")
            case .images(let breed): return Endpoint.baseURL.appendingPathComponent("/breed/\(breed.name)/images")
            }
        }
    }
    
    public enum Error: LocalizedError {
        case invalidResponse
        case failedToDecodeData
        
        public var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Error Fetching Woof Data: Invalid Response"
            case .failedToDecodeData: return "Failed to decode data"
            }
        }
    }
    
    // MARK: - Interface -
    
    // MARK: - Functions -
    
    // MARK: - Public -
    
    public func fetchBreeds(result: @escaping BreedsListResult) {
        URLSession.shared.dataTask(with: Endpoint.list.url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                result(.failure(.invalidResponse))
                return
            }
            self.handleData(data: data, result: result)
        }.resume()
    }
    
    // MARK: - Private -
    
    private func handleData(data: Data?, result: @escaping BreedsListResult) {
        guard let data = data else {
            result(.failure(.failedToDecodeData))
            return
        }
        
        guard let decoded = try? decoder.decode(BreedsRawResponse.self, from: data) else {
            result(.failure(.failedToDecodeData))
            return
        }
        
        result(.success(decoded.message))
    }
}
