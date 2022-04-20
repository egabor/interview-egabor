//
//  ArticleDetailViewController.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 15..
//

import UIKit
import Combine

class ArticleDetailViewController: UIViewController {

    var disposables = Set<AnyCancellable>()

    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!

    @Injected var viewModel: ArticleDetailViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        setupBindings()
    }

    private func setupBindings() {
        viewModel.$imageUrl
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { imageUrl in
                self.coverImageView.loadImageUrl(imageURL: imageUrl)
            }).store(in: &disposables)

        viewModel.$title
            .compactMap { $0 }
            .assign(to: \.text, on: titleLabel)
            .store(in: &disposables)

        viewModel.$content
            .compactMap { $0 }
            .assign(to: \.text, on: contentLabel)
            .store(in: &disposables)
    }
}
