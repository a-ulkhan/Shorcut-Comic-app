//
//  ComicService.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import Foundation

struct ComicResponse: Codable {
    let month: String
    let num: Int
    let link: String?
    let year, safeTitle: String
    let transcript: String?
    let img: String
    let day: String

    enum CodingKeys: String, CodingKey {
        case month, num, link, year
        case safeTitle = "safe_title"
        case transcript, img, day
    }
}

/*
 Provider could be set up to provide
 either from local storage(in case no internet/ or
 other business logic) or via url request.
 But here no need since no db implemented
 */
protocol ComicProvider {
    func getComicBy(_ number: Int, completion: @escaping ((Result<ComicResponse, NetworkError>) -> Void))
}

final class ComicProviderImpl: ComicProvider {
    func getComicBy(_ number: Int, completion: @escaping ((Result<ComicResponse, NetworkError>) -> Void)) {
        let url = "https://xkcd.com/\(number)/info.0.json"
        SimpleNetworkManager.shared.fireRequest(url, responseType: ComicResponse.self) { result in
            completion(result)
        }
    }
}
