//
//  GameDetailsDomainModel.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

struct GameDetailsDomainModel {
    let id: Int
    let title: String
    let gameURL: URL
    let thumbnailURL: URL?
    let status, shortDescription, description: String?
    let category, publisher, developer: String?
    let supportedPlatforms: [String]
    let releaseDate: String?
    let profileURL: URL?
    let minimumSystemRequirements: MinimumSystemRequirements?
    let screenshots: [Screenshot]
    
    init?(apiModel: GameDetailsAPIModel) {
        guard let _id = apiModel.id,
              let _title = apiModel.title,
              let _gameURLString = apiModel.gameURL,
              let _gameURL = URL(string: _gameURLString) else {
            return nil
        }
        self.id = _id
        self.title = _title
        self.gameURL = _gameURL
        self.thumbnailURL = URL(string: apiModel.thumbnail ?? "")
        self.status = apiModel.status
        self.shortDescription = apiModel.shortDescription
        self.description = apiModel.description
        self.category = apiModel.genre
        self.publisher = apiModel.publisher
        self.developer = apiModel.developer
        self.releaseDate = apiModel.releaseDate
        self.profileURL = URL(string: apiModel.freetogameProfileURL ?? "")
        self.minimumSystemRequirements = apiModel.minimumSystemRequirements
        self.screenshots = apiModel.screenshots?
            .map { Screenshot(id: $0.id, url: URL(string: $0.image)) } ?? []
        self.supportedPlatforms = apiModel.platform?.components(separatedBy: ",") ?? []
    }
}

struct Screenshot: Codable {
    let id: Int
    let url: URL?
}
