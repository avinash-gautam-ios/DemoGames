//
//  KeyValueTableViewCell.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit
import SnapKit

final class KeyValueTableViewCell: UITableViewCell, TableCell {

    private let keyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = Theme.Font.titleFont
        label.textColor = Theme.Color.titleColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = Theme.Font.descriptionFont
        label.textColor = Theme.Color.descriptionColor
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: KeyValueTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(keyLabel)
        keyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Padding.padding20)
            make.top.equalToSuperview().offset(Theme.Padding.padding10)
            make.bottom.equalToSuperview().offset(-Theme.Padding.padding10)
        }
        
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(keyLabel.snp.trailing).offset(Theme.Padding.padding10)
            make.top.equalToSuperview().offset(Theme.Padding.padding10)
            make.bottom.equalToSuperview().offset(-Theme.Padding.padding10)
        }
    }
    
    func configure(withKey key: String, forValue value: String) {
        self.keyLabel.text = key
        self.valueLabel.text = value
    }
    
    func configure(forModel model: GameDetailsDomainModel, type: GameDetailsTableItemType) {
        switch type {
        case .category:
            configure(withKey: type.displayValue,
                      forValue: model.category ?? "")
        case .platform:
            configure(withKey: type.displayValue,
                      forValue: model.supportedPlatforms.joined(separator: ", ") )
        case .publisher:
            configure(withKey: type.displayValue,
                      forValue: model.publisher ?? "")
        case .developer:
            configure(withKey: type.displayValue,
                      forValue: model.developer ?? "")
        case .releaseDate:
            configure(withKey: type.displayValue,
                      forValue: model.releaseDate ?? "")
        case .description:
            configure(withKey: type.displayValue,
                      forValue: model.description ?? "")
        case .screenshots:
            break
        }
    }
}
