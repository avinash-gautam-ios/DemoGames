//
//  Constants.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit

enum Constants {
    
    enum String {
        static let welcomeTitle = "Welcome, Gamers!"
        static let listOfGames = "Showing list of games sorted by"
        static let filteredBy = ", filtered by"
        static let platformFor = ", for"
        static let fetchingGames = "Fetching games.."
        static let fetchingDetails = "Fetching details.."
        static let genericError = "Error fetching data. Please try again"
        static let retryButton = "Retry"
        static let details = "Details"
        static let description = "Description"
        static let screenshots = "Screenshots"
        static let lauchGame = "Launch Game"
        static let platformButton = "Platform"
        static let categoryButton = "Category"
        static let sortButton = "Sort-by"
    }
}


enum Theme {
    
    enum Font {
        static let headerFont = UIFont.boldSystemFont(ofSize: 18)
        static let titleFont = UIFont.boldSystemFont(ofSize: 14)
        static let descriptionFont = UIFont.systemFont(ofSize: 14)
    }
    
    enum Color {
        static let headerColor = UIColor.black
        static let titleColor = UIColor.black
        static let descriptionColor = UIColor.gray
        static let navTintColor = UIColor.black
        static let blackButtonColor = UIColor.white
    }
    
    enum BackgroundColor {
        static let cellBackgroundColor = UIColor.white
        static let viewBackgroundColor = UIColor.white
        static let imageviewBackgroundColor = UIColor.darkGray
        static let tagColor = UIColor.lightGray.withAlphaComponent(0.6)
    }
    
    enum Padding {
        static let padding5: CGFloat = 5
        static let padding10: CGFloat = 10
        static let padding20: CGFloat = 20
    }
    
    enum CornerRadius {
        static let `default`: CGFloat = 4
    }
    
    enum Multiplier {
        static let heightWidthMultiplier: CGFloat = 0.65
    }
    
    enum IconSize {
        static let small: CGFloat = 10
        static let medium: CGFloat = 30
        static let large: CGFloat = 50
        static let xxl: CGFloat = 100
    }
    
}
