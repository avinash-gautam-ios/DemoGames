//
//  DescriptionTableViewCell.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit

final class DescriptionTableViewCell: UITableViewCell, TableCell {

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = Theme.Font.descriptionFont
        label.textColor = Theme.Color.descriptionColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: DescriptionTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = Theme.BackgroundColor.cellBackgroundColor
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Theme.Padding.padding20)
            make.trailing.bottom.equalToSuperview().offset(-Theme.Padding.padding20)
        }
    }
    
    func configure(withText text: String) {
        descriptionLabel.text = text
    }
    
    func configure(forModel model: GameDetailsDomainModel) {
        configure(withText: model.description ?? model.shortDescription ?? "")
    }
}
