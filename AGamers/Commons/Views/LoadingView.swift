//
//  LoadingView.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit

final class FullScreenLoadingView: UIView {

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .gray
        return spinner
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
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
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-Theme.Padding.padding20)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Padding.padding20)
            make.trailing.equalToSuperview().offset(-Theme.Padding.padding20)
            make.top.equalTo(spinner.snp.bottom)
        }
    }
    
    func startLoading(text: String) {
        descriptionLabel.text = text
        spinner.startAnimating()
    }
    
    func stopLoading(_ completion: () -> Void) {
        spinner.stopAnimating()
        completion()
    }

}
