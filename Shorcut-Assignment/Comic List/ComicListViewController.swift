//
//  ComicListViewController.swift
//  Shorcut-Assignment
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import UIKit

final class ComicListViewController: UIViewController {
    // MARK: UI components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private lazy var refreshControl = UIRefreshControl()
    // MARK: Properties
    private var viewModel: ComicListViewModel
    private var dataSource: ComicDataSource = ComicDataSourceImpl()

    init(viewModel: ComicListViewModel) {
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
        setBindings()
    }

    private func setup() {
        view.backgroundColor = .white
        title = "Comics"
        tableView.register(ComicCell.self, forCellReuseIdentifier: String(describing: ComicCell.self))
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
    }

    private func layout() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
            .forEach { $0.isActive = true }
    }

    private func setBindings() {
        viewModel.getComics()
        refreshControl.beginRefreshing()
        viewModel.onDataRecieved = { [weak self] dataSource in
            guard let self = self else { return }
            self.dataSource = dataSource
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }

        viewModel.onError = { [weak self] errorReason in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            let alert = UIAlertController(title: "ERROR", message: errorReason, preferredStyle: .alert)
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                alert.dismiss(animated: true)
            }
        }
    }

    @objc private func reload() {
        refreshControl.beginRefreshing()
        viewModel.getComics()
    }
}

extension ComicListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.item(at: indexPath) {
        case .comic(let model):
            let identifier = String(describing: ComicCell.self)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ComicCell
            else { fatalError("Cell should be inited correctly") }
            cell.displayModel(model)

            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.numberOfSection
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(dataSource.heightFor(indexPath: indexPath))
        return height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath)
    }
}
