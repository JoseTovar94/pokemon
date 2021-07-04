//
//  MovesTableViewCell.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit
import Material

class TypesMovesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    // MARK: - Vars
    var viewModel: DashboardViewModel.Moves? {
        didSet {
            updateView()
        }
    }
    
    var viewModelTypes: DashboardViewModel.Types? {
        didSet {
            updateViewTypes()
        }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.depth = Depth(offset: .zero, opacity: 0.1, radius: 10)
        containerView.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Setup
    func updateView() {
        nameLabel.set(sub: "Moves Name: ", des: viewModel?.move?.name ?? "", fontSize: 16)
        urlLabel.set(sub: "URL: ", des: viewModel?.move?.url ?? "", fontSize: 16)
    }
    
    func updateViewTypes() {
        nameLabel.set(sub: "Type Name: ", des: viewModelTypes?.type?.name ?? "", fontSize: 16)
        urlLabel.set(sub: "Slot: ", des: viewModelTypes?.slot ?? "", fontSize: 16)
    }
}
