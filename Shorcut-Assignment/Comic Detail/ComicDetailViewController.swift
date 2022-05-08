//
//  ComicDetailViewController.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 08.05.22.
//

import UIKit

final class ComicDetailViewController: UIViewController {
    // MARK: UI components
    private lazy var titleLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var descriptionLabel = UILabel()
    // MARK: Properties
    private var viewModel: ComicDetailViewModel

    init(viewModel: ComicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }

    private func setup() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        title = "Comics Detail"
        let displayData = viewModel.displayData
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        titleLabel.text = displayData.title

        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = displayData.description

        imageView.contentMode = .scaleAspectFit
        if let imageURL = displayData.imageURL {
            imageView.sd_setImage(with: imageURL)
        }
    }

    private func layout() {
        [
            titleLabel,
            imageView,
            descriptionLabel
        ]
            .forEach { view.addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalTo(imageView.snp.top).inset(-16)
        }

        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(160)
            $0.bottom.equalTo(descriptionLabel.snp.top).inset(-8)
        }

        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(12)
        }
    }
}
