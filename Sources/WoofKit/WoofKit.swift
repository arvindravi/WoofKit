import Foundation
import UIKit

public class WoofKit {
    
    // MARK: - Properties -
    
    // MARK: - Private -
    
    private let decoder = JSONDecoder()
    
    // MARK: - Internal -
    
    // MARK: - Public -
    
    public typealias BreedsListResult = (Result<[Breed], Error>) -> Void
    public typealias ImagesListResult = (Result<[UIImage], Error>) -> Void
    public static let shared: WoofKit = WoofKit()
    
    // MARK: - Custom Types
    
    enum Endpoint {
        static let baseURL = URL(string: "https://dog.ceo/api/")!
        
        case list
        case images(ofBreed: String, subBreed: String?)
        
        var url: URL {
            switch self {
            case .list: return Endpoint.baseURL.appendingPathComponent("breeds/list/all")
            case .images(let breed, let subBreed): return Endpoint.baseURL.appendingPathComponent("breed/\(breed)/images")
            }
        }
    }
    
    public enum Error: LocalizedError {
        case invalidResponse
        case failedToDecodeData
        
        public var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Error Fetching Woof Data: Invalid Response"
            case .failedToDecodeData: return "Error Fetching Woof Data: Failed to decode data"
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
    
    public func fetchImages(for breed: String, subBreed: String? = nil, result: @escaping ImagesListResult) {
        URLSession.shared.dataTask(with: Endpoint.images(ofBreed: breed, subBreed: subBreed).url) { (data, response, error) in
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
    
    private func handleData(data: Data?, result: @escaping ImagesListResult) {
        guard let data = data else {
            result(.failure(.failedToDecodeData))
            return
        }
        
        guard let decoded = try? decoder.decode(ImagesRawResponse.self, from: data) else {
            result(.failure(.failedToDecodeData))
            return
        }
        
        let imageURLs = Array(decoded.message.shuffled().prefix(10))
        images(for: imageURLs, result: result)
    }
    
    private func images(for urls: [URL], result: @escaping ImagesListResult) {
        guard urls.count > 0 else {
            result(.failure(.invalidResponse))
            return
        }
        
        let loader = ImageLoader()
        var images = [UIImage]()
        urls.forEach { url in
            loader.loadImage(for: url as NSURL) { imageResult in
                switch imageResult {
                case .success(let image): images.append(image)
                case .failure(let error): print("Error Loading Image: \(error.localizedDescription)")
                }
            }
        }
        print(images)
    }
}
