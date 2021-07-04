//
//  AbilitiesTableViewCell.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit
import Material

class DetailTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hiddenLabel: UILabel!
    @IBOutlet weak var slotLabel: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerView.depth = Depth(offset: .zero, opacity: 0.1, radius: 10)
        containerView.layer.cornerRadius = 15.0
    }
    
    // MARK: - Setup
    func setup(textOne: String, textTwo: String, textThree: String, titleOne: String, titleTwo: String, tilteThree: String) {
        nameLabel.set(sub: titleOne, des: textOne, fontSize: 16)
        hiddenLabel.set(sub: titleTwo, des: textTwo, fontSize: 16)
        slotLabel.set(sub: tilteThree, des: textThree, fontSize: 16)
    }
    
}
