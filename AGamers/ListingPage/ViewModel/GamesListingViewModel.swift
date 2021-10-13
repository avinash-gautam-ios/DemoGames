//
//  GamesHomePageViewModel.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

/**
 * View Model input
 */
protocol GamesListingViewModelInput: AnyObject {
    /// table view datasource for item type: GameListingDomainDataModel,
    /// section: TableSection<GameListingDomainDataModel>
    var datasource: TableDataSource<GameListingDomainDataModel,
                                    TableSection<GameListingDomainDataModel>> { get }
    
    /// updates viewmodel of view loaded
    func viewLoaded()
    
    /// updates viewmodel to show game detail page
    func showDetails(item: GameListingDomainDataModel)
    
    /// show selected filter type
    func showFilterDetails(forType type: GamesListingFilterType)
    
    /// updates viewmodel of selected filters
    func updateSelectedFilterItems(_ items: [String])
    
    /// reset all the filters to default
    func resetAllFilters()
}

/**
 * View Model output
 */
protocol GamesListingViewModelOutput: AnyObject {
    /// updates view about state changes, possible values are error, loding and content
    func didUpdateState(_ state: GamesListingViewState)
    
    /// updates view about navigation to game details page
    func presentGameDetails(withModel viewModel: GameDetailsViewModel)
    
    /// updates view to open filter selection page
    func presentFilterSelection(title: String,
                                preselectedItems: [String],
                                items: [String],
                                allowsMultiSelection: Bool)
}

/**
 * View state for listing view
 */
enum GamesListingViewState {
    case loading(message: String)
    case error(message: String, buttonTitle: String)
    case content(title: String, subtitle: NSAttributedString)
}

/**
 * Possible filter selection types
 */
enum GamesListingFilterType {
    case category
    case platform
    case sort
    
    /// defines where for the selected filter, multiple selection should be allowed or not
    var allowsMultiSelect: Bool {
        switch self {
        case .category:
            return false
        case .platform:
            return false
        case .sort:
            return false
        }
    }
}


final class GamesListingViewModel: GamesListingViewModelInput {
    
    /// pre-defined filters
    private enum Defaults {
        static let defaultSort = [GameListingFilters.sortings.first ?? ""]
        static let defaultPlatform = [GameListingFilters.platforms.first ?? ""]
        static let defaultCategory = [String]()
    }
    
    /// properties
    
    weak var output: GamesListingViewModelOutput?
    private var currentSort: [String]
    private var currentPlatform: [String]
    private var currentCategory: [String]
    private var currentSelectedFilterType: GamesListingFilterType?
    private var subtitle: String
    private var title: String
    private(set) var datasource: TableDataSource<GameListingDomainDataModel,
                                                 TableSection<GameListingDomainDataModel>>
    
    init(title: String) {
        self.title = title
        self.subtitle = ""
        self.currentSort = Defaults.defaultSort
        self.currentPlatform = Defaults.defaultPlatform
        self.currentCategory = Defaults.defaultCategory
        self.datasource = TableDataSource<GameListingDomainDataModel,
                                          TableSection<GameListingDomainDataModel>>(sections: [])
    }
    
    //MARK: GamesHomePageViewModelInput
    
    func viewLoaded() {
        output?.didUpdateState(.content(title: title, subtitle: NSAttributedString(string: "")))
        output?.didUpdateState(.loading(message: Constants.String.fetchingGames))
        fetchGamesListing()
    }
    
    func showDetails(item: GameListingDomainDataModel) {
        output?.presentGameDetails(withModel: GameDetailsViewModel(gameId: item.id, title: item.title))
    }
    
    func showFilterDetails(forType type: GamesListingFilterType) {
        /// update selected filter type
        currentSelectedFilterType = type
        let title: String
        let preselectedItems: [String]
        let items: [String]
        switch type {
        case .category:
            title = Constants.String.categoryButton
            preselectedItems = currentCategory
            items = GameListingFilters.categories
        case .platform:
            title = Constants.String.platformButton
            preselectedItems = currentPlatform
            items = GameListingFilters.platforms
        case .sort:
            title = Constants.String.sortButton
            preselectedItems = currentSort
            items = GameListingFilters.sortings
        }
        
        /// show filter selection
        output?.presentFilterSelection(title: title,
                                       preselectedItems: preselectedItems,
                                       items: items,
                                       allowsMultiSelection: type.allowsMultiSelect)
    }
    
    func updateSelectedFilterItems(_ items: [String]) {
        /// update the filters and refresh
        guard let type = currentSelectedFilterType else {
            return
        }
        switch type {
        case .category:
            currentCategory = items
        case .platform:
            currentPlatform = items
        case .sort:
            currentSort = items
        }
        refesh()
    }
    
    func resetAllFilters() {
        /// reset last selected filter type
        currentSelectedFilterType = nil
        
        /// reset to default filters and refresh
        currentSort = Defaults.defaultSort
        currentPlatform = Defaults.defaultPlatform
        currentCategory = Defaults.defaultCategory
        refesh()
    }
    
    // MARK: - Private
     
    private func refesh() {
        self.datasource = TableDataSource<GameListingDomainDataModel, TableSection<GameListingDomainDataModel>>(sections: [])
        output?.didUpdateState(.loading(message: Constants.String.fetchingDetails))
        fetchGamesListing()
    }
    
    private func fetchGamesListing() {
        /// endpoint
        let endpoint = GameListingEndpoint(platform: currentPlatform,
                                           sorting: currentSort,
                                           category: currentCategory)
        /// request
        let request = GameListingServiceRequest(endpoint: endpoint)
        /// make request
        Dependency.networkCore.makeRequest(request) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let response):
                Dependency.logger.log(type: .message, "Success for request: \(request.endpoint)")
                Execute.onMain { this.handleResponse(response: response) }
            case .failure(let error):
                Dependency.logger.log(type: .error, error.localizedDescription)
                Execute.onMain { this.handleError(error: error) }
            }
        }
    }
    
    private func handleResponse(response: GameListingAPIModel) {
        let model = GameListingDomainModel(apiModel: response)
        if model.games.count == 0 {
            handleError(error: HTTPNetworkError.responseDataNil)
            return
        }
        
        let section = TableSection(items: model.games)
        datasource = TableDataSource(sections: [section])
        output?.didUpdateState(.content(title: title, subtitle: prepareSubtitleWithFilters()))
    }
    
    private func handleError(error: Error) {
        let message = error.asNetworkError?.message ?? Constants.String.genericError
        output?.didUpdateState(.error(message: message, buttonTitle: Constants.String.retryButton))
    }
    
    private func prepareSubtitleWithFilters() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: Constants.String.listOfGames)
        let attributedSpace = NSAttributedString(string: " ")
        let attributedComma = NSAttributedString(string: ", ")
        
        for (index, sort) in currentSort.enumerated() {
            let attributedSort = NSAttributedString(string: sort,
                                                    attributes: [NSAttributedString.Key.font: Theme.Font.titleFont,
                                                                 NSAttributedString.Key.foregroundColor: Theme.Color.titleColor])
            attributedText.append(attributedSpace)
            attributedText.append(attributedSort)
            if (index < currentCategory.count - 1) {
                attributedText.append(attributedComma)
            }
        }
        
        /// add category
        for (index, category) in currentCategory.enumerated() {
            let filterAttribute = NSAttributedString(string: Constants.String.filteredBy)
            let attributedCategory = NSAttributedString(string: category,
                                                        attributes: [NSAttributedString.Key.font : Theme.Font.titleFont,
                                                                     NSAttributedString.Key.foregroundColor: Theme.Color.titleColor])
            attributedText.append(filterAttribute)
            attributedText.append(attributedSpace)
            attributedText.append(attributedCategory)
            if (index < currentCategory.count - 1) {
                attributedText.append(attributedComma)
            }
        }
        
        /// add platform
        for (index, platform) in currentPlatform.enumerated() {
            let platformAttribute = NSAttributedString(string: Constants.String.platformFor)
            let attributedPlatfrom = NSAttributedString(string: platform,
                                                        attributes: [NSAttributedString.Key.font : Theme.Font.titleFont,
                                                                     NSAttributedString.Key.foregroundColor: Theme.Color.titleColor])
            attributedText.append(platformAttribute)
            attributedText.append(attributedSpace)
            attributedText.append(attributedPlatfrom)
            if (index < currentCategory.count - 1) {
                attributedText.append(attributedComma)
            }
        }
        
        return attributedText
    }
}
