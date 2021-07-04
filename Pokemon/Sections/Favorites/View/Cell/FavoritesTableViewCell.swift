//
//  FavoritesTableViewCell.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 3/07/21.
//

import UIKit
import Material

class FavoritesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoritesImage: UIImageView!
    
    
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
    func setup(url: String) {
        let imageURL2 = Constants.Request.baseImage + url + ".png"
        favoritesImage.setImage(with: imageURL2)
    }
}
