//
//  ErrorView.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapButton(_ errorView: ErrorView)
}

final class ErrorView: UIView {
    
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Theme.Font.descriptionFont
        label.textAlignment = .center
        label.textColor = Theme.Color.descriptionColor
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(Theme.Color.titleColor, for: .normal)
        button.titleLabel?.font = Theme.Font.descriptionFont
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ErrorViewDelegate?
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(errorImageView)
        errorImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Theme.IconSize.medium)
            make.centerY.equalToSuperview().offset(-Theme.Padding.padding20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(errorMessageLabel)
        errorMessageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Padding.padding20)
            make.trailing.equalToSuperview().offset(-Theme.Padding.padding20)
            make.top.equalTo(errorImageView.snp.bottom)
        }
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(errorMessageLabel.snp.bottom).offset(Theme.Padding.padding10)
            make.centerX.equalToSuperview()
        }
    }
    
    func setErrorText(text: String) {
        self.errorMessageLabel.text = text
    }
    
    func setButtonText(_ text: String) {
        button.setTitle(text, for: .normal)
    }
    
    func setErrorImage(_ image: UIImage) {
        self.errorImageView.image = image
    }
    
    @objc private func buttonAction() {
        delegate?.didTapButton(self)
    }
}
