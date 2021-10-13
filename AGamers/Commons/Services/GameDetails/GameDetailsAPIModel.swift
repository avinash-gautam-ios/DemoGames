//
//  GameDetailsAPIModel.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

struct GameDetailsAPIModel: Codable {
    let id: Int?
    let title: String?
    let thumbnail: String?
    let status: String?
    let shortDescription: String?
    let description: String?
    let gameURL: String?
    let genre: String?
    let platform: String?
    let publisher: String?
    let developer: String?
    let releaseDate: String?
    let freetogameProfileURL: String?
    let minimumSystemRequirements: MinimumSystemRequirements?
    let screenshots: [ScreenshotApiModel]?

    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, status
        case shortDescription = "short_description"
        case description = "description"
        case gameURL = "game_url"
        case genre, platform, publisher, developer
        case releaseDate = "release_date"
        case freetogameProfileURL = "freetogame_profile_url"
        case minimumSystemRequirements = "minimum_system_requirements"
        case screenshots
    }
}

// MARK: - MinimumSystemRequirements

struct MinimumSystemRequirements: Codable {
    let os, processor, memory, graphics: String?
    let storage: String?
}

// MARK: - Screenshot

struct ScreenshotApiModel: Codable {
    let id: Int
    let image: String
}
