//
//  GameDetailsViewModel.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

/**
 * View model input
 */
protocol GameDetailsViewModelInput: AnyObject {
    /// table data source
    var datasource: TableDataSource<GameDetailsTableItem, GameDetailsTableSection> { get }
    
    /// updates viewmodel about view is loaded
    func viewLoaded()
    
    /// updates viewmodel about launch game
    func didTapLaunchButton()
}

/**
 * View model output
 */
protocol GameDetailsViewModelOutput: AnyObject {
    /// updates view about state changes, possible values are error, loding and content
    func didUpdateState(_ state: GameDetailsViewState)
    
    /// launch game from game url
    func launchGame(withURL url: URL)
}

/**
 * View states for game detail screen
 */
enum GameDetailsViewState {
    case loading(text: String)
    case error(message: String, buttonTitle: String)
    case content(title: String, headerImageURL: URL?)
}

final class GameDetailsViewModel: GameDetailsViewModelInput {
    
    /// properties
    
    private(set) var datasource: TableDataSource<GameDetailsTableItem, GameDetailsTableSection>
    private let gameId: Int
    private let gameTitle: String
    private var gameDetails: GameDetailsDomainModel?
    weak var output: GameDetailsViewModelOutput?
    
    init(gameId: Int, title: String) {
        self.gameId = gameId
        self.gameTitle = title
        self.datasource = TableDataSource<GameDetailsTableItem, GameDetailsTableSection>(sections: [])
    }
    
    // MARK: - GameDetailsViewModelInput
    
    func viewLoaded() {
        output?.didUpdateState(.content(title: gameTitle, headerImageURL: nil))
        output?.didUpdateState(.loading(text: Constants.String.fetchingDetails))
        fetchGameDetails()
    }
    
    func didTapLaunchButton() {
        guard let gameURL = gameDetails?.gameURL else {
            Dependency.logger.log(type: .critial, "game url was nil for launching game: \(String(describing: gameDetails))")
            return
        }
        output?.launchGame(withURL: gameURL)
    }
    
    //MARK: - Private
    
    private func fetchGameDetails() {
        let endpoint = GameDetailsEndPoint(id: gameId)
        let request = GameDetailsServiceRequest(endpoint: endpoint)
        Dependency.networkCore.makeRequest(request) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let response):
                Dependency.logger.log(type: .message, "success: \(endpoint)")
                Execute.onMain { this.handleResponse(response: response) }
            case .failure(let error):
                Dependency.logger.log(type: .error, error.localizedDescription)
                Execute.onMain { this.handleError(error: error) }
            }
        }
    }
    
    private func handleResponse(response: GameDetailsAPIModel) {
        if let model = GameDetailsDomainModel(apiModel: response) {
            prepareTableDatasource(model: model)
            gameDetails = model
            output?.didUpdateState(.content(title: model.title, headerImageURL: model.thumbnailURL))
        } else {
            handleError(error: HTTPNetworkError.responseDataNil)
        }
    }
    
    private func handleError(error: Error) {
        let message = error.asNetworkError?.message ?? Constants.String.genericError
        output?.didUpdateState(.error(message: message, buttonTitle: Constants.String.retryButton))
    }
    
    private func prepareTableDatasource(model: GameDetailsDomainModel) {
        var sections = [GameDetailsTableSection]()
        
        ///1. details section
        var detailItems = [GameDetailsTableItem]()
        if let _ = model.category {
            detailItems.append(GameDetailsTableItem(type: .category, data: model))
        }
        
        if model.supportedPlatforms.count > 0 {
            detailItems.append(GameDetailsTableItem(type: .platform, data: model))
        }
        
        if let _ = model.publisher {
            detailItems.append(GameDetailsTableItem(type: .publisher, data: model))
        }
        
        if let _ = model.developer {
            detailItems.append(GameDetailsTableItem(type: .developer, data: model))
        }
        
        if let _ = model.releaseDate {
            detailItems.append(GameDetailsTableItem(type: .releaseDate, data: model))
        }
        
        /// only if atleast one detail is present show the section
        if detailItems.count > 0 {
            sections.append(GameDetailsTableSection(type: .details, items: detailItems))
        }
        
        /// 2. description
        if let _ = model.description {
            let descriptionItems = [GameDetailsTableItem(type: .description, data: model)]
            sections.append(GameDetailsTableSection(type: .description, items: descriptionItems))
        }
        
        /// 3. screenshots
        if model.screenshots.count > 0 {
            let screenshotItems = [GameDetailsTableItem(type: .screenshots, data: model)]
            sections.append(GameDetailsTableSection(type: .screenshots, items: screenshotItems))
        }
        
        /// update data source
        self.datasource = TableDataSource<GameDetailsTableItem, GameDetailsTableSection>(sections: sections)
    }
}
