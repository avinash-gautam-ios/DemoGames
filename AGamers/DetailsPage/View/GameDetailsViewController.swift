//
//  GameDeatilsViewController.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit
import SafariServices

final class GameDetailsViewController: UIViewController {
    
    /// properties
    
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
        view.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        return view
    }()
    
    private lazy var tableHeaderView: UIImageView = {
        let width = view.bounds.size.width - Theme.Padding.padding20
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width * Theme.Multiplier.heightWidthMultiplier))
        imageView.backgroundColor = Theme.BackgroundColor.imageviewBackgroundColor
        return imageView
    }()
    
    private lazy var launchGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.Color.navTintColor
        button.titleLabel?.font = Theme.Font.titleFont
        button.titleLabel?.textColor = Theme.Color.blackButtonColor
        button.setTitle(Constants.String.lauchGame, for: .normal)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: GameDetailsViewModelInput
    
    init(viewModel: GameDetailsViewModel) {
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
        tableView.register(cell: KeyValueTableViewCell.self)
        tableView.register(cell: DescriptionTableViewCell.self)
        tableView.register(cell: ScreenshotsTableViewCell.self)
    }
    
    private func configureUI() {
        view.backgroundColor = Theme.BackgroundColor.viewBackgroundColor
        
        view.addSubview(tableView)
        tableView.tableHeaderView = tableHeaderView
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        view.addSubview(launchGameButton)
        launchGameButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Theme.IconSize.large)
            make.top.equalTo(tableView.snp.bottom).offset(Theme.Padding.padding10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func startGame() {
        viewModel.didTapLaunchButton()
    }
    
    private func handleContentState(title: String, headerImageURL: URL?) {
        navigationItem.title = title
        loadingView.removeFromSuperview()
        errorView.removeFromSuperview()
        tableView.isHidden = false
        tableView.reloadData()
        tableHeaderView.sd_setImage(with: headerImageURL, completed: nil)
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
    
    private func handleLoadingState(message: String) {
        tableView.isHidden = true
        errorView.removeFromSuperview()
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        loadingView.layer.zPosition = 1
        loadingView.startLoading(text: message)
    }
    
}

//MARK: - Table View

extension GameDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.datasource.sections[indexPath.section]
        switch section.type {
        case .screenshots:
            let cell = tableView.dequeueReusableCell(withIdentifier: ScreenshotsTableViewCell.identifier)
                .flatMap { $0 as? ScreenshotsTableViewCell } ?? ScreenshotsTableViewCell()
            cell.selectionStyle = .none
            cell.configure(forModel: section.items[indexPath.row].data)
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier)
                .flatMap { $0 as? DescriptionTableViewCell } ?? DescriptionTableViewCell()
            cell.selectionStyle = .none
            cell.configure(forModel: section.items[indexPath.row].data)
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(withIdentifier: KeyValueTableViewCell.identifier)
                .flatMap { $0 as? KeyValueTableViewCell } ?? KeyValueTableViewCell()
            cell.selectionStyle = .none
            cell.configure(forModel: section.items[indexPath.row].data,
                           type: section.items[indexPath.row].type)
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.datasource.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.numberOfItems(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.datasource.sections[section].type.displayValue
    }
}

//MARK: - View Model Output

extension GameDetailsViewController: GameDetailsViewModelOutput {
    func didUpdateState(_ state: GameDetailsViewState) {
        switch state {
        case .content(title: let title, headerImageURL: let url):
            handleContentState(title: title, headerImageURL: url)
        case .error(message: let error, buttonTitle: let buttonTitle):
            handleErrorState(message: error, buttonTitle: buttonTitle)
        case .loading(text: let text):
            handleLoadingState(message: text)
        }
    }
    
    func launchGame(withURL url: URL) {
        let safariController = SFSafariViewController(url: url)
        self.present(safariController, animated: true, completion: nil)
    }
}
