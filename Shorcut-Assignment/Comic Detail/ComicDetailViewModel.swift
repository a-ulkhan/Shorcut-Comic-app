//
//  ComicDetailViewModel.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 08.05.22.
//

import Foundation

protocol ComicDetailViewModel {
    var displayData: ComicDetailDisplayData { get set }
}

struct ComicDetailDisplayData {
    let title, description: String
    let imageURL: URL?
}

final class ComicDetailViewModelImpl: ComicDetailViewModel {
    var displayData: ComicDetailDisplayData

    init(displayData: ComicDetailDisplayData) {
        self.displayData = displayData
    }
}
