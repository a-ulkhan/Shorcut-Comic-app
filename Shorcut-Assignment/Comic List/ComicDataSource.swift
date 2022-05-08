//
//  ComicDataSource.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation

struct ComicSectionModel {
    enum SectionType {
        case comic(_ model: ComicCellModel)
    }
    var items: [SectionType]
}

protocol ComicDataSource {
    var sections: [ComicSectionModel] { get set }
    var numberOfSection: Int { get }
    func numberOfRows(in section: Int) -> Int
    func heightFor(indexPath: IndexPath) -> Double
    func item(at indexPath: IndexPath) -> ComicSectionModel.SectionType
}

final class ComicDataSourceImpl: ComicDataSource {
    var sections: [ComicSectionModel]
    var numberOfSection: Int {
        sections.count
    }

    init(_ sections: [ComicSectionModel] = []) {
        self.sections = sections
    }

    func numberOfRows(in section: Int) -> Int {
        sections[section].items.count
    }

    func item(at indexPath: IndexPath) -> ComicSectionModel.SectionType {
        sections[indexPath.section].items[indexPath.row]
    }
    func heightFor(indexPath: IndexPath) -> Double {
        /* - We can give different height config based different items,
         however we have single item so static(or UITableView.automaticDimension) can be returned
         Idealy return CGFloat but it's in UIKit framework and
         we definetly don't want to import uikit unless it's ui component
         */
        return 200
    }
}
