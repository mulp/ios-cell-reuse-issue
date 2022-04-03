//
//  ItemTableViewCell.swift
//  CellReuseIssue
//
//  Created by Fabio on 3/4/22.
//

import Foundation
import UIKit
import SnapKit

final class ItemTableViewCell: UITableViewCell {
    static var Identifier = "ItemTableViewCellIdentifier"
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    private(set) public var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        return label
    }()
    private(set) lazy var timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        return label
    }()
    private(set) var actionsButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.setImage(UIImage(named: "btn_icon"), for: .normal)
        button.imageView?.image?.withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = .gray
            return button
    }()
    private let itemContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 4
        return view
    }()
    private(set) lazy var itemTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()

    public init() {
        super.init(style: .default, reuseIdentifier: "ItemTableViewCellIdentifier")
        setupSubviews()
        setupConstraints()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: Private methods
    private func setupSubviews() {
        [topStackView, actionsButton, itemContainer].forEach(contentView.addSubview)
        itemContainer.addSubview(itemTextLabel)
        [userImageView, nameLabel, timestampLabel].forEach(topStackView.addArrangedSubview)
    }

    private func setupConstraints() {
        topStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(44)
        }
        actionsButton.snp.makeConstraints { make in
            make.centerY.equalTo(topStackView.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
            make.width.height.equalTo(24)
        }
        itemContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(topStackView.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
        }
        itemTextLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
        }
        userImageView.snp.makeConstraints { make in
            make.width.height.equalTo(23)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        timestampLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        itemTextLabel.text = nil
        userImageView.image = nil
        nameLabel.text = nil
        timestampLabel.text = nil
    }

    func configure(with model: ModelItem, for userId: String) {
        userImageView.backgroundColor = .red
        nameLabel.text = model.username
        nameLabel.sizeToFit()

        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH:mm, MMM d"
        timestampLabel.text = dateformat.string(from: model.createdAt)
        timestampLabel.sizeToFit()

        itemTextLabel.text = model.content
    }
}
