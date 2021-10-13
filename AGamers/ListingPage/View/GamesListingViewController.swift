//
//  GamesHomePageViewController.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 25.09.21.
//

import UIKit
import SnapKit

final class GamesListingViewController: UIViewController {
    
    /// properties
    
    private lazy var filterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Theme.Color.descriptionColor
        label.font = Theme.Font.descriptionFont
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var loadingView: FullScreenLoadingView = {
        let loader = FullScreenLoadingView()
        loader.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        return loader
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.delegate = self
        view.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.Color.navTintColor
        button.titleLabel?.font = Theme.Font.titleFont
        button.titleLabel?.textColor = Theme.Color.blackButtonColor
        button.setTitle(Constants.String.categoryButton, for: .normal)
        button.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var platformButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.Color.navTintColor
        button.titleLabel?.font = Theme.Font.titleFont
        button.titleLabel?.textColor = Theme.Color.blackButtonColor
        button.setTitle(Constants.String.platformButton, for: .normal)
        button.addTarget(self, action: #selector(platformButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.Color.navTintColor
        button.titleLabel?.font = Theme.Font.titleFont
        button.titleLabel?.textColor = Theme.Color.blackButtonColor
        button.setTitle(Constants.String.sortButton, for: .normal)
        button.addTarget(self, action: #selector(sortingButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: GamesListingViewModelInput
    
    init(viewModel: GamesListingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewLoaded()
        registerCells()
        configureUI()
    }
    
    private func registerCells() {
        tableView.register(cell: GameListingTableViewCell.self)
    }
    
    private func configureUI() {
        view.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        
        view.addSubview(filterDescriptionLabel)
        filterDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Padding.padding20)
            make.trailing.equalToSuperview().offset(-Theme.Padding.padding20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Theme.Padding.padding20)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Padding.padding20)
            make.trailing.equalToSuperview().offset(-Theme.Padding.padding20)
            make.top.equalTo(filterDescriptionLabel.snp.bottom).offset(Theme.Padding.padding10)
        }
        
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(Theme.Padding.padding10)
            make.leading.equalToSuperview().offset(Theme.Padding.padding20)
            make.trailing.equalToSuperview().offset(-Theme.Padding.padding20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(Theme.IconSize.medium)
        }
        
        buttonStackView.addArrangedSubview(sortingButton)
        buttonStackView.addArrangedSubview(platformButton)
        buttonStackView.addArrangedSubview(categoryButton)
    }
    
    private func handleContentState(title: String, subtitle: NSAttributedString) {
        loadingView.removeFromSuperview()
        navigationItem.title = title
        filterDescriptionLabel.attributedText = subtitle
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func handleLoadingState(text: String) {
        tableView.isHidden = true
        errorView.removeFromSuperview()
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        loadingView.layer.zPosition = 1
        loadingView.startLoading(text: text)
    }
    
    private func handleErrorState(message: String, buttonTitle: String) {
        tableView.isHidden = true
        loadingView.removeFromSuperview()
        view.addSubview(errorView)
        errorView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        errorView.layer.zPosition = 1
        errorView.setErrorText(text: message)
        errorView.setButtonText(buttonTitle)
    }
    
    @objc private func categoryButtonAction() {
        viewModel.showFilterDetails(forType: .category)
    }
    
    @objc private func platformButtonAction() {
        viewModel.showFilterDetails(forType: .platform)
    }
    
    @objc private func sortingButtonAction() {
        viewModel.showFilterDetails(forType: .sort)
    }
}

//MARK: - Table View

extension GamesListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameListingTableViewCell.identifier)
            .flatMap { $0 as? GameListingTableViewCell } ?? GameListingTableViewCell()
        cell.configure(withModel: viewModel.datasource.item(atIndex: indexPath.row, section: indexPath.section))
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.datasource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.numberOfItems(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showDetails(item: viewModel.datasource.item(atIndex: indexPath.row, section: indexPath.section))
    }
}

//MARK: - View Model Output

extension GamesListingViewController: GamesListingViewModelOutput {
    func didUpdateState(_ state: GamesListingViewState) {
        switch state {
        case .error(message: let message, buttonTitle: let buttonTitle):
            handleErrorState(message: message, buttonTitle: buttonTitle)
        case .content(title: let title, subtitle: let subtitle):
            handleContentState(title: title, subtitle: subtitle)
        case .loading(message: let text):
            handleLoadingState(text: text)
        }
    }
    
    func presentGameDetails(withModel viewModel: GameDetailsViewModel) {
        let detailsVC = GameDetailsViewController(viewModel: viewModel)
        detailsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func presentFilterSelection(title: String,
                                preselectedItems: [String],
                                items: [String],
                                allowsMultiSelection: Bool) {
        let vc = MultiSelectTableViewController(items: items,
                                                preselectedItems: preselectedItems,
                                                allowsMultipleSelecton: allowsMultiSelection,
                                                title: title)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Custom View Outupts

extension GamesListingViewController: MultiSelectTableViewControllerDelegate {
    func didSelectItems(_ items: [String]) {
        viewModel.updateSelectedFilterItems(items)
    }
}

extension GamesListingViewController: ErrorViewDelegate {
    func didTapButton(_ errorView: ErrorView) {
        viewModel.resetAllFilters()
    }
}
