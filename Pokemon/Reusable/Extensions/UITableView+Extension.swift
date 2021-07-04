//
//  UITableView+Extension.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

extension UITableView {
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false

        self.tableHeaderView = headerView

        // ** Must setup AutoLayout after set tableHeaderView.
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }

    func shouldUpdateHeaderViewFrame() -> Bool {
        guard let headerView = self.tableHeaderView else { return false }
        let oldSize = headerView.bounds.size
        // Update the size
        headerView.layoutIfNeeded()
        let newSize = headerView.bounds.size
        return oldSize != newSize
    }
    
    func register(cell: TableViewCellCatalog, identifier: CellReuseIdentifierAll) {
        register(.instantiate(withCell: cell), forCellReuseIdentifier: identifier.rawValue)
    }
}
extension UINib {
    static func instantiate(withCell cell: TableViewCellCatalog) -> UINib {
        let view = UINib(nibName: cell.rawValue, bundle: nil)
        return view
    }
}
