import Foundation
import UIKit

public class WoofKit {
    
    // MARK: - Properties
    
    // MARK: - Private -
    
    private let decoder = JSONDecoder()
    
    // MARK: - Internal -
    
    typealias BreedsListResult = (Result<[Breed], Error>) -> Void

    // MARK: - Public -
    
    public let shared: WoofKit = WoofKit()
    // MARK: - Custom Types
    
    enum BreedsEndpoint {
        static let baseURL = URL(string: "https://dog.ceo/api/")!
        
        case list
        case images(ofBreed: Breed)
        
        var url: URL {
            switch self {
            case .list: return BreedsEndpoint.baseURL.appendingPathComponent("list/all")
            case .images(let breed): return BreedsEndpoint.baseURL.appendingPathComponent("/breed/\(breed.name)/images")
            }
        }
    }
    
    enum Error: LocalizedError {
        case invalidResponse
        case failedToDecodedData
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Error Fetching Woof Data: Invalid Response"
            case .failedToDecodedData: return "Failed to decode data"
            }
        }
    }
    
    func fetchBreeds(result: @escaping BreedsListResult) {
        let task = URLSession.shared.dataTask(with: BreedsEndpoint.list.url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                result(.failure(.invalidResponse))
                return
            }
            
            self.handleData(data: data, result: result)
        }
        task.resume()
    }
    
    private func handleData(data: Data?, result: @escaping BreedsListResult) {
        guard let data = data else {
            result(.failure(.failedToDecodedData))
            return
        }
        
        guard let decoded = try? decoder.decode(BreedsRawResponse.self, from: data) else {
            result(.failure(.failedToDecodedData))
            return
        }
        
        result(.success(decoded.message))
    }
}
