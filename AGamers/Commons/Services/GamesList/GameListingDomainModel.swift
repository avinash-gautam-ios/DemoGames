//
//  GameDomainModel.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

struct GameListingDomainModel {
    
    let games: [GameListingDomainDataModel]
    
    init(apiModel: GameListingAPIModel) {
        var _games = [GameListingDomainDataModel]()
        for model in apiModel {
            if let _domainModel = GameListingDomainDataModel(apiModel: model) {
                _games.append(_domainModel)
            }
        }
        games = _games
    }
}

struct GameListingDomainDataModel {
    let id: Int
    let title: String
    let thumbnailURL: URL?
    let shortDescription: String?
    let gameURL: URL
    let category: String?
    let supportedPlatforms: [String]
    let publisher: String?
    let developer: String?
    let releaseDate: String?
    let profileURL: URL?
    
    init?(apiModel: GameListingAPIDataModel) {
        /// if id for a game does not exist, dont create a model
        /// report error
        guard let _id = apiModel.id,
              let _title = apiModel.title,
              let _gameURLString = apiModel.gameURL,
              let _gameURL = URL(string: _gameURLString) else {
            return nil
        }
        
        self.id = _id
        self.gameURL = _gameURL
        self.title = _title
        self.thumbnailURL = URL(string: apiModel.thumbnail ?? "")
        self.profileURL = URL(string: apiModel.profileURL ?? "")
        self.shortDescription = apiModel.shortDescription
        self.category = apiModel.genre
        self.publisher = apiModel.publisher
        self.developer = apiModel.developer
        self.releaseDate = apiModel.releaseDate
        self.supportedPlatforms = apiModel.platform?.components(separatedBy: ",") ?? []
    }
}
