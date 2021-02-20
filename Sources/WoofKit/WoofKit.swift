import Foundation
import UIKit

public class WoofKit {
    
    // MARK: - Properties
    
    // MARK: - Private -
    
    private let decoder = JSONDecoder()
    
    // MARK: - Internal -
    

    // MARK: - Public -
    
    public typealias BreedsListResult = (Result<[Breed], Error>) -> Void
    public static let shared: WoofKit = WoofKit()
    
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
    
    public enum Error: LocalizedError {
        case invalidResponse
        case failedToDecodedData
        
        public var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Error Fetching Woof Data: Invalid Response"
            case .failedToDecodedData: return "Failed to decode data"
            }
        }
    }
    
    public func fetchBreeds(result: @escaping BreedsListResult) {
        URLSession.shared.dataTask(with: BreedsEndpoint.list.url.request) { (data, _, _) in
            self.handleData(data: data, result: result)
        }.resume()
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

private extension URL {
    var request: URLRequest { URLRequest(url: self) }
}
