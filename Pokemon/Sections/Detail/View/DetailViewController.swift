//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var idPokemon = "3"
    private lazy var modelController: DetailViewModelController = {
        let modelController = DetailViewModelController()
        modelController.attach(view: self)
        return modelController
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        modelController.viewDidLoad(id: idPokemon)

    }
    
    // MARK: - Get Cell Identifier
    func getCellIdentifier(idState: String?) -> String {
        var cellIdentifier = CellReuseIdentifierAll.GeneralTableViewCell
        let getIndex = idState ?? "0"
        switch CategoryHomeDashBoard(rawValue: getIndex) {
        case .head:
            cellIdentifier = .TitleCell
        case .abilities, .stats:
            cellIdentifier = .DetailCell
        case .moves, .types:
            cellIdentifier = .TypesCell
        case .general:
            cellIdentifier = .GeneralTableViewCell
        case .sprites:
            cellIdentifier = .SpritesTableViewCell
        default: break
        }
        return cellIdentifier.rawValue
    }
}
// MARK: - Table DataSource & Delegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        tableView.register(cell: .DetailTableViewCell, identifier: .DetailCell)
        tableView.register(cell: .TypesMovesTableViewCell, identifier: .TypesCell)
        tableView.register(cell: .GeneralTableViewCell, identifier: .GeneralTableViewCell)
        tableView.register(cell: .TitleTableViewCell, identifier: .TitleCell)
        tableView.register(cell: .SpritesTableViewCell, identifier: .SpritesTableViewCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = getCellIdentifier(idState: modelController.viewModel.cells[indexPath.row].idState)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        let cellData = modelController.viewModel.cells[indexPath.row]
        if let resultCell = cell as? DetailTableViewCell {
            if cellData.abilitiesViewModel != nil {
                resultCell.setup(textOne: cellData.abilitiesViewModel?.ability?.name ?? "", textTwo: cellData.abilitiesViewModel?.isHidden ?? "", textThree: cellData.abilitiesViewModel?.slot ?? "", titleOne: "Ability Name: ", titleTwo: "Hidden: ", tilteThree: "Slot: ")
            } else {
                resultCell.setup(textOne: cellData.stats?.stat?.name ?? "", textTwo: cellData.stats?.baseStat ?? "", textThree: cellData.stats?.effort ?? "", titleOne: "Stat Name: ", titleTwo: "Base: ", tilteThree: "Effort: ")
            }
        } else if let resultCell = cell as? TitleTableViewCell {
            resultCell.resultViewModel = cellData.headViewModel
        } else if let resultCell = cell as? TypesMovesTableViewCell {
            if cellData.moves != nil {
                resultCell.viewModel = cellData.moves
            } else {
                resultCell.viewModelTypes = cellData.types
            }
        } else if let resultCell = cell as? GeneralTableViewCell {
            resultCell.viewModel = cellData.general
        } else if let resultCell = cell as? SpritesTableViewCell {
            let viewModel = cellData.sprites ?? .init()
            resultCell.configure(with: viewModel)
        }
        
        return cell
    }
}
// MARK: - View Model Protocol
extension DetailViewController: DetailProtocol {
    
    func reloadUI() {
        tableView.reloadData()
    }
}
