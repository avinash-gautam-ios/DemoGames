//
//  GameDetailsTableViewDatasource.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

enum GameDetailsTableItemType {
    case category, platform, publisher, developer, releaseDate, description, screenshots
    
    var displayValue: String {
        switch self {
        case .category:
            return "Category"
        case .platform:
            return "Platform"
        case .publisher:
            return "Publisher"
        case .developer:
            return "Developer"
        case .releaseDate:
            return "Release date"
        case .description:
            return "Description"
        case .screenshots:
            return "Screenshots"
        }
    }
}

enum GameDetailsTableSectionType {
    case details, description, screenshots
    
    var displayValue: String {
        switch self {
        case .details:
            return Constants.String.details
        case .description:
            return Constants.String.description
        case .screenshots:
            return Constants.String.screenshots
        }
    }
}

struct GameDetailsTableItem {
    let type: GameDetailsTableItemType
    let data: GameDetailsDomainModel
}


final class GameDetailsTableSection: TableSection<GameDetailsTableItem> {
    let type: GameDetailsTableSectionType
    
    init(type: GameDetailsTableSectionType,
         items: [GameDetailsTableItem]) {
        self.type = type
        super.init(items: items)
    }
}
