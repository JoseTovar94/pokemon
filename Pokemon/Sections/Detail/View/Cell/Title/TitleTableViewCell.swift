//
//  TitleTableViewCell.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Vars
    var resultViewModel: DashboardViewModel.HeadViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup
    private func updateView() {
        titleLabel.text = resultViewModel?.text
    }
    
}
