//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

class SpritesTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Vars
    var viewModel = [DashboardViewModel.SpritesViewModel]()

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(SpritesCollectionViewCell.nib(), forCellWithReuseIdentifier: SpritesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Setup
    func configure(with models: [DashboardViewModel.SpritesViewModel]) {
        self.viewModel = models
        collectionView.reloadData()
    }
    
    // MARK: - ScrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
// MARK: - Collection DataSource & Delegate
extension SpritesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = viewModel.count
        pageControl.isHidden = !(viewModel.count > 1)
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpritesCollectionViewCell.identifier, for: indexPath)

        if let resultCell = cell as? SpritesCollectionViewCell {
            resultCell.viewModel = viewModel[indexPath.row]
           
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        //return CGSize(width: screenSize.width - 40, height: 190) xib = 5
        return CGSize(width: screenSize.width, height: 190)
    }
}
