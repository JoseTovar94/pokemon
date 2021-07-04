//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private lazy var modelController: HomeViewModelController = {
        let modelController = HomeViewModelController()
        modelController.attach(view: self)
        return modelController
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        modelController.viewDidLoad()
        tableView.accessibilityIdentifier = "table--Home"

    }
    
    // MARK: - Actions
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        setNextView(nextPage: .Like)

    }
    @IBAction func favoritesButtonTapped(_ sender: UIButton) {
        setNextView(nextPage: .Favorites)
    }
}

// MARK: - Table DataSource & Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        tableView.register(cell: .HomeTableViewCell, identifier: .HomeTableViewCell)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.viewModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell {
            cell.selectionStyle = .none
            //cell.setup(viewModel: modelController.viewModel?.results?[indexPath.row])
            cell.setup(viewModel: modelController.resultsAtIndex(indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setNextView(nextPage: .Detail,parametershowView: String(indexPath.row + 1))
    }
    
}
// MARK: - View Model Protocol
extension HomeViewController: HomeProtocol {
    func reloadUI() {
        tableView.reloadData()
    }
}
