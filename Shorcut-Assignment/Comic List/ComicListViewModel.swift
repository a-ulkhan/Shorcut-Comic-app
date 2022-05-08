//
//  ComicListViewModel.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation

protocol ComicListViewModelDelegate: AnyObject {
    func showDetails(with data: ComicResponse)
}

protocol ComicListViewModel {
    var onDataRecieved: ((ComicDataSource) -> Void)? { get set }
    var onError: ((_ reason: String) -> Void)? { get set }
    var isLoading: Bool { get set }
    var delegate: ComicListViewModelDelegate? { get set }
    var provider: ComicProvider { get set }
    func getComics()
    func selectItem(at indexPath: IndexPath)
}

final class ComicListViewModelImpl: ComicListViewModel {
    private var data: [ComicResponse] = []
    var onDataRecieved: ((ComicDataSource) -> Void)?
    var onError: ((_ reason: String) -> Void)?
    var isLoading: Bool = false
    weak var delegate: ComicListViewModelDelegate?
    var provider: ComicProvider

    init(provider: ComicProvider) {
        self.provider = provider
    }

    func getComics() {
        isLoading = true
        let group = DispatchGroup()
        var data: [ComicResponse] = []
        (1...12).forEach { index in
            group.enter()
            provider.getComicBy(index) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    data.append(response)
                    group.leave()
                case .failure(let error):
                    self.onError?(error.errorReason)
                    group.leave()
                }
            }

            group.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.data = data
                let dataSource = self.makeDataSource(from: self.data)
                self.onDataRecieved?(dataSource)
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
                urlToShare: URL(string: response.link ?? ""),
                isFavorite: false
            )
            items.append(.comic(model))
        }

        return ComicDataSourceImpl([ComicSectionModel(items: items)])
    }

    func selectItem(at indexPath: IndexPath) {
        let response = data[indexPath.row]
        delegate?.showDetails(with: response)
    }
}
