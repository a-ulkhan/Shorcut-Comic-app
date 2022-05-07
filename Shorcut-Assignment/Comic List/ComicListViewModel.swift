//
//  ComicListViewModel.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation

protocol ComicListViewModel {
    var onDataRecieved: ((ComicDataSource) -> Void)? { get set }
    var onError: ((_ reason: String) -> Void)? { get set }
    var isLoading: Bool { get set }
    var provider: ComicProvider { get set }
    func getComic(forIndex index: Int)
}

final class ComicListViewModelImpl: ComicListViewModel {
    private var data: [ComicResponse] = []
    var onDataRecieved: ((ComicDataSource) -> Void)?
    var onError: ((_ reason: String) -> Void)?
    var isLoading: Bool = false
    var provider: ComicProvider
    
    init(provider: ComicProvider) {
        self.provider = provider
    }
    
    func getComic(forIndex index: Int) {
        isLoading = true
        provider.getComicBy(index) { result in
            self.isLoading = false
            switch result {
            case .success(let response):
                self.data.append(response)
                let dataSource = self.makeDataSource(from: self.data)
                self.onDataRecieved?(dataSource)
            case .failure(let error):
                self.onError?(error.errorReason)
            }
        }
    }

    private func makeDataSource(from data: [ComicResponse]) -> ComicDataSource {
        var items = [ComicSectionModel.SectionType]()
        data.forEach { response in
            let model = ComicCellModel(
                title: response.safeTitle,
                number: response.num,
                date: "\(response.month) / \(response.year)",
                imgURL: URL(string: response.img),
                urlToShare: URL(string: response.link),
                isFavorite: false
            )
            items.append(.comic(model))
        }
    
        return ComicDataSourceImpl([ComicSectionModel(items: items)])
    }
}
