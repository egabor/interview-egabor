//
//  ArticleCell.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import UIKit

class ArticleCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var coverImage: UIImageView!

    public func setup(with data: ArticleCellModel) {
        timeLabel.text = data.publishedAt.timeAgo()
        titleLabel.text = data.title
        coverImage.loadImageUrl(imageURL: data.urlToImage)
    }
}
