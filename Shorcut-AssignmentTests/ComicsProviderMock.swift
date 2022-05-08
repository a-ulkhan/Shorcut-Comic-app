//
//  ComicsProviderMock.swift
//  Shorcut-AssignmentTests
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation
@testable import Shorcut_Assignment

final class ComicProviderMock: ComicProvider {
    var shouldFailWith: NetworkError?

    func getComicBy(_ number: Int, completion: @escaping ((Result<ComicResponse, NetworkError>) -> Void)) {
        if let error = shouldFailWith {
            completion(.failure(error))
        } else {
            let response = ComicResponse(
                month: "5",
                num: number,
                link: nil,
                year: "2022",
                safeTitle: "Title",
                transcript: nil,
                img: "",
                day: "2"
            )
            completion(.success(response))
        }
    }
}
