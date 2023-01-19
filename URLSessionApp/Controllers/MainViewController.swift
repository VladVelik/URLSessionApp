//
//  MainViewController.swift
//  URLSessionApp
//
//  Created by Sosin Vladislav on 18.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    private let tableView = UITableView()
    private var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setConstraints()
        fetchInfo()
    }
    
    private func fetchInfo() {
        NetworkManager.shared.fetchImagesInfo(url: URLs.postsList) { images in
            DispatchQueue.main.async {
                self.images = images
                self.tableView.reloadData()
            }
        }
    }
    
    private func setTableView() {
        tableView.rowHeight = 100
        view.addSubview(tableView)

        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MainViewController: UITableViewDelegate {}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configure(
            id: "id: " + (images[indexPath.row].id ?? "0"),
            author: "author: " + (images[indexPath.row].author ?? "unknown"),
            img: images[indexPath.row].download_url ?? ""
        )
        return cell
    }
}
