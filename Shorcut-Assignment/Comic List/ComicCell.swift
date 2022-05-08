//
//  ComicCell.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import UIKit
import SDWebImage
import SnapKit

final class ComicCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let numberLabel = UILabel()
    private let dateLabel = UILabel()
    private let comicImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        selectionStyle = .none

        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 18)

        numberLabel.textColor = .lightGray
        numberLabel.font = .systemFont(ofSize: 12)

        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textAlignment = .right

        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal

        comicImageView.contentMode = .scaleAspectFit
    }

    private func layout() {
        [
            titleLabel,
            stackView,
            comicImageView
        ]
            .forEach { contentView.addSubview($0) }
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(dateLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalTo(stackView.snp.top).inset(-16)
        }

        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.equalTo(comicImageView.snp.top).inset(-8)
        }

        comicImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(12)
        }
    }

    func displayModel(_ model: ComicCellModel) {
        titleLabel.text = model.title
        numberLabel.text = "nr: \(model.number)"
        dateLabel.text = "date: \(model.date)"
        if let imageURL = model.imgURL {
            comicImageView.sd_setImage(with: imageURL)
        }
    }
}
