//
//  GameListingFilters.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

struct GameListingFilters {
    
    static let categories = [
        "mmorpg", "shooter", "strategy", "moba", "racing", "sports", "social", "sandbox", "open-world",
        "survival", "pvp", "pve", "pixel", "voxel", "zombie", "turn-based", "first-person", "third-Person",
        "top-down", "tank", "space", "sailing", "side-scroller", "superhero", "permadeath", "card",
        "battle-royale", "mmo", "mmofps", "mmotps", "3d", "2d", "anime", "fantasy", "sci-fi", "fighting",
        "action-rpg", "action", "military", "martial-arts", "flight", "low-spec", "tower-defense", "horror",
        "mmorts"
    ]
    
    static let platforms = [
        "all", "pc", "browser"
    ]
    
    static let sortings = [
        "release-date", "relevance", "popularity", "alphabetical"
    ]
}
