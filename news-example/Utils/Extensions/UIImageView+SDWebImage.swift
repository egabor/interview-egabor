//
//  UIImageView+SDWebImage.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import UIKit
import SDWebImage

extension UIImageView {

    public func loadImageUrl(imageURL: String?, defaultImage: UIImage? = nil) {
        let placeholderImage = defaultImage ?? UIImage(named: "ic_image")
        guard let imageURL = imageURL else {
            image = nil
            return
        }
        self.sd_setImage(with: URL(string: imageURL),
                         placeholderImage:
                            placeholderImage, options: []) { [weak self] (image, error, _, url) in
            if URL(string: imageURL) == url {
                if error == nil {
                    self?.image = image
                } else {
                    self?.image = placeholderImage
                }
            } else {
                self?.image = placeholderImage
            }
        }
    }

}
