//
//  ImageFetcher.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

protocol ImageFetching {
    func fetchImage(at url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class ImageFetcher: ImageFetching {

    static let shared = ImageFetcher()

    let imageCache = NSCache<NSString, UIImage>()

    func fetchImage(at url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {

        let cacheKey = url.absoluteString as NSString

        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(.success(cachedImage))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: cacheKey)
                completion(.success(image))
            }
        }

        task.resume()
    }

}
