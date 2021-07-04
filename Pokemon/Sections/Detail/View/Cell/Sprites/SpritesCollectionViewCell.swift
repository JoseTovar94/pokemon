//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

class SpritesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Vars
    var viewModel = DashboardViewModel.SpritesViewModel() {
        didSet {
            updateView()
        }
    }
    
    static let identifier = "SpritesCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SpritesCollectionViewCell", bundle: nil)
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate func updateView() {
        imageView.setImage(with: viewModel.name)
    }

}
