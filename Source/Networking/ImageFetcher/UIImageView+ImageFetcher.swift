//
//  UIImageView+ImageFetcher.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, using fetcher: ImageFetching = ImageFetcher.shared) {
        fetcher.fetchImage(at: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
