//
//  GentilView.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 3/07/21.
//

import UIKit
import Material

class CustomView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()

    }
    // MARK: - Setup
    private func commonInit(){
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        containerView.depth = Depth(offset: .zero, opacity: 1, radius: 20)
        containerView.layer.cornerRadius = 40
    }

}
