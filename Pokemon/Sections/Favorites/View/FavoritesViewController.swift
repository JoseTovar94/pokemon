//
//  FavoritesViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 3/07/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private lazy var modelController: FavoritesViewModelController = {
        let modelController = FavoritesViewModelController()
        modelController.attach(view: self)
        return modelController
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        modelController.viewDidLoad()
    }
}

// MARK: - Table DataSource & Delegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        tableView.register(cell: .FavoritesTableViewCell, identifier: .FavoritesCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? FavoritesTableViewCell {
            cell.selectionStyle = .none
            cell.setup(url: modelController.array[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - View Model Protocol
extension FavoritesViewController: FavoriteProtocol {
    func reloadUI() {
        tableView.reloadData()
    }
}

