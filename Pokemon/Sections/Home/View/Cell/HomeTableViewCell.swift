//
//  SearchTableViewCell.swift
//  Acronyms
//
//  Created by Jose Luis Tovar Jimenez on 27/03/21.
//

import UIKit
import Material

class HomeTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.depth = Depth(offset: .zero, opacity: 0.1, radius: 10)
        viewContainer.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Actions
    func setup(viewModel: PokemonResult?) {
        titleLabel.text = viewModel?.name
        let imageComplete = viewModel?.url ?? ""
        let splitImage = imageComplete.components(separatedBy: "/")
        let imageURL2 = Constants.Request.baseImage + splitImage[splitImage.count - 2] + ".png"
        imagePokemon.setImage(with: imageURL2)

    }
    
}
