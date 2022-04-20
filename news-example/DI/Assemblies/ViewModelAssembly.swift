//
//  ViewModelAssembly.swift
//  news-example
//
//  Created by Eszenyi Gábor on 2021. 04. 14..
//

import Swinject

class ViewModelAssembly: Assembly {

    func assemble(container: Container) {

        container.register(ArticlesViewModel.self) { _ in
            ArticlesViewModel()
        }

        container.register(ArticleDetailViewModel.self) { _ in
            ArticleDetailViewModel()
        }
    }
}
