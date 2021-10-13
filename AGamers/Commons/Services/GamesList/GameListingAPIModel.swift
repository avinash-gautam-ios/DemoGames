//
//  GameAPIModel.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

struct GameListingAPIDataModel: Codable {
    let id: Int?
    let title: String?
    let thumbnail: String?
    let shortDescription: String?
    let gameURL: String?
    let genre, platform, publisher, developer: String?
    let releaseDate: String?
    let profileURL: String?

    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail
        case shortDescription = "short_description"
        case gameURL = "game_url"
        case genre, platform, publisher, developer
        case releaseDate = "release_date"
        case profileURL = "freetogame_profile_url"
    }
}

typealias GameListingAPIModel = [GameListingAPIDataModel]



