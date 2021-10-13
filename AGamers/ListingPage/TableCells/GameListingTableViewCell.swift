//
//  GameTableViewCell.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit
import SDWebImage

final class GameListingTableViewCell: UITableViewCell, TableCell {
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Theme.BackgroundColor.imageviewBackgroundColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Theme.Font.titleFont
        label.textColor = Theme.Color.titleColor
        return label
    }()
    
    private let gameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = Theme.Font.descriptionFont
        label.textColor = Theme.Color.descriptionColor
        return label
    }()
    
    private let categoryTagView: TagView = {
        let tagView = TagView()
        return tagView
    }()
    
    private var platformTagViews: [TagView] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: GameListingTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        platformTagViews.forEach({ $0.removeFromSuperview() })
        platformTagViews.removeAll()
    }
    
    private func configureUI() {
        contentView.backgroundColor = Theme.BackgroundColor.cellBackgroundColor
        contentView.addSubview(gameImageView)
        gameImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(Theme.Padding.padding20)
            make.height.equalTo(contentView.snp.width).multipliedBy(Theme.Multiplier.heightWidthMultiplier)
        }
        
        contentView.addSubview(gameTitleLabel)
        gameTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(gameImageView.snp.bottom).offset(Theme.Padding.padding10)
        }
        
        contentView.addSubview(categoryTagView)
        categoryTagView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(gameTitleLabel.snp.bottom).offset(Theme.Padding.padding5)
            make.width.greaterThanOrEqualTo(Theme.IconSize.medium)
        }
        
        contentView.addSubview(gameDescriptionLabel)
        gameDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(categoryTagView.snp.bottom).offset(Theme.Padding.padding10)
            make.bottom.equalToSuperview().offset(-Theme.Padding.padding10)
        }
        
    }
    
    func configure(withModel model: GameListingDomainDataModel) {
        self.gameTitleLabel.text = model.title
        self.gameDescriptionLabel.text = model.shortDescription
        self.gameImageView.sd_setImage(with: model.thumbnailURL, completed: nil)
        self.categoryTagView.update(text: model.category ?? "")
        
        var previousPlatformView = categoryTagView
        for platform in model.supportedPlatforms {
            let platformTagView = TagView()
            contentView.addSubview(platformTagView)
            platformTagView.snp.makeConstraints { make in
                make.leading.equalTo(previousPlatformView.snp.trailing).offset(Theme.Padding.padding10)
                make.top.equalTo(gameTitleLabel.snp.bottom).offset(Theme.Padding.padding5)
                make.width.greaterThanOrEqualTo(Theme.IconSize.medium)
            }
            platformTagView.update(text: platform)
            platformTagViews.append(platformTagView)
            previousPlatformView = platformTagView
        }
    }
    
}
