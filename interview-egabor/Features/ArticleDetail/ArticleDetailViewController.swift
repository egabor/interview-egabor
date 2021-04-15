//
//  ArticleDetailViewController.swift
//  interview-egabor
//
//  Created by Eszenyi Gábor on 2021. 04. 15..
//

import UIKit
import RxSwift

class ArticleDetailViewController: UIViewController {

    let disposeBag = DisposeBag()

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
        viewModel.imageUrl.asObservable().subscribe { [weak self] imageUrl in
            self?.coverImageView.loadImageUrl(imageURL: imageUrl)
        }.disposed(by: disposeBag)
        viewModel.title.asObservable().bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.content.asObservable().bind(to: contentLabel.rx.text).disposed(by: disposeBag)
    }
}
