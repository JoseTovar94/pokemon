//
//  GeneralTableViewCell.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit
import Material

class GeneralTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var HeightLabel: UILabel!
    @IBOutlet weak var ExperienceLabel: UILabel!
    
    
    // MARK: - Vars
    var viewModel: DashboardViewModel.GeneralDetail? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.depth = Depth(offset: .zero, opacity: 0.1, radius: 10)
        viewContainer.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup
    func updateView() {
        nameLabel.set(sub: "Name: ", des: viewModel?.name ?? "", fontSize: 16)
        idLabel.set(sub: "ID: ", des: viewModel?.id ?? "", fontSize: 16)
        weightLabel.set(sub: "Weight: ", des: viewModel?.weight ?? "", fontSize: 16)
        HeightLabel.set(sub: "Height: ", des: viewModel?.height ?? "", fontSize: 16)
        ExperienceLabel.set(sub: "Base Experience: ", des: viewModel?.baseExperience ?? "", fontSize: 16)
    }
}
