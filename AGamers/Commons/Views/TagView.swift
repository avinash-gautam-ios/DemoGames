//
//  TagView.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit

final class TagView: UIView {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Theme.Font.titleFont
        label.textColor = Theme.Color.titleColor
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = Theme.BackgroundColor.tagColor
        layer.cornerRadius = Theme.CornerRadius.default
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Theme.Padding.padding5)
            make.bottom.trailing.equalToSuperview().offset(-Theme.Padding.padding5)
        }
    }
    
    func update(text: String) {
        textLabel.text = text
    }
    
}
