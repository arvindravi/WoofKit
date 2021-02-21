//
//  File.swift
//  
//
//  Created by Arvind Ravi on 21/02/2021.
//

import Foundation
import UIKit

class ImageLoader {
 
    // MARK: - Custom Types -
    
    public enum Error: Swift.Error {
        case failedToLoadImage
    }
    
    // MARK: - Properties -
    
    var cache = NSCache<NSURL, UIImage>()
    
    // MARK: - Interface -
    
    // MARK: - Methods -
    
    func loadImage(for url: NSURL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(.success(cachedImage))
                return
            }
        }
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: url as URL) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.failedToLoadImage))
                }
                return
            }
            self.cache.setObject(image, forKey: url)
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }
    
    private func image(url: NSURL) -> UIImage? {
        cache.object(forKey: url)
    }
}
