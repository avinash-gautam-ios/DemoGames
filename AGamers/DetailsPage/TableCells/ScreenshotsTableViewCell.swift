//
//  ScreenshotsTableViewCell.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import UIKit

final class ScreenshotsTableViewCell: UITableViewCell, TableCell {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let scrollStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Theme.Padding.padding10
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private var imageViews = [UIImageView]()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViews.forEach { scrollStackView.removeArrangedSubview($0) }
        imageViews.removeAll()
    }
    
    private func configureUI() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Theme.Padding.padding20)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(Theme.Padding.padding10)
            make.bottom.equalToSuperview().offset(-Theme.Padding.padding10)
            make.height.equalTo(2 * Theme.IconSize.xxl)
        }
        
        scrollView.addSubview(scrollStackView)
        scrollStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.height.equalTo(scrollView.snp.height)
        }
    }
    
    func configure(forImageURLs urls: [URL]) {
        for url in urls {
            let imageView = UIImageView(frame: .zero)
            imageView.contentMode = .scaleToFill
            scrollStackView.addArrangedSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.width.equalTo(contentView.snp.width).offset(-2 * Theme.Padding.padding20)
            }
            imageView.sd_setImage(with: url, completed: nil)
            imageViews.append(imageView)
        }
    }
    
    func configure(forModel model: GameDetailsDomainModel) {
        let urls = model.screenshots.compactMap { $0.url }
        configure(forImageURLs: urls)
    }

}
