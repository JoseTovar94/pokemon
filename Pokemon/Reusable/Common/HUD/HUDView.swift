//
//  HUDView.swift
//  Acronyms
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

@IBDesignable
class HUDView: UIView {
    
    static var shared: HUDView = HUDView()
    
    // MARK: IBOutlets
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var maskBackground: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var progressView: CircularView!
    @IBOutlet var titleBottomConstraint: NSLayoutConstraint!
    
    var originalWindow: UIWindow?
    
    lazy var progressWindow: UIWindow = {
        var window = UIWindow(frame: UIScreen.main.bounds)
        
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared
                .connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
            
            if let windowScene = windowScene as? UIWindowScene {
                window = UIWindow(windowScene: windowScene)
            }
        }
        
        window.frame = UIScreen.main.bounds
        
        //        let lastWindow = UIApplication .shared.windows.last
        //        window.windowLevel = lastWindow?.windowLevel + 1
        window.windowLevel = UIWindow.Level.alert - 1
        return window
    }()
    
    lazy var isPresenting: Bool = {
        return superview != nil
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        nibSetup()
    }
    
    private func nibSetup() {
        translatesAutoresizingMaskIntoConstraints = true
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = true
        
        self.alpha = 0.0
        
        customizeView()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first
        
        return nibView as? UIView ?? UIView()
    }
    
    fileprivate func addTo(view: UIView? = nil) {
        let containerView = view ?? progressWindow
        self.removeAllConstraints()
        DispatchQueue.main.async {
            self.removeFromSuperview()
            containerView.addSubview(self)
            containerView.bringSubviewToFront(self)
        }
        
        frame = containerView.frame
        
        if view == nil {
            originalWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            progressView.isHidden = false
            progressWindow.makeKeyAndVisible()
        }
    }
    
    // MARK: - Customizations
    fileprivate func customizeView() {
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        
        // Shadow
        mainView.layer.masksToBounds = false
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 8
        mainView.layer.shadowOpacity = 0.3
        
        progressView.trackColor = .pokemonPrimaryAlpha10
        progressView.lineWidth = 2.0
    }
    
    // MARK: - Animations
    fileprivate func animateAppear() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                self.alpha = 1.0
            }, completion: nil
        )
    }
    
    func show(in view: UIView? = nil, title: String? = nil, progress: CGFloat? = nil) {
        if let title = title {
            titleLabel.text = title
            titleBottomConstraint.isActive = true
            titleLabel.isHidden = false
        } else {
            titleLabel.text = ""
            titleBottomConstraint.isActive = false
            titleLabel.isHidden = true
        }
        
//        DispatchQueue.main.async {
            if let progress = progress {
                self.progressView.stop()
                self.progressView.setProgress(value: progress, withDuration: 0.1)
            } else {
                DispatchQueue.main.async {
                    self.progressView.startIndeterminate()
                }
            }
            
            if !self.isPresenting {
                self.addTo(view: view)
                self.animateAppear()
            }
//        }
    }
    
    func update(title: String? = nil, progress: CGFloat? = nil) {
        if let title = title {
            titleLabel.text = title
        }
        
        if let progress = progress {
            if progress == -1 {
                DispatchQueue.main.async {
                    self.progressView.startIndeterminate()
                }
            } else {
                progressView.stop()
                progressView.setProgress(value: progress)
            }
        }
    }
    
    func dismiss(animated: Bool = false) {
//        DispatchQueue.main.async {
            self.progressView.stop()
            let block = {
                DispatchQueue.main.async {
                    self.removeAllConstraints()
                    self.removeFromSuperview()
                }
                self.originalWindow?.makeKeyAndVisible()
                self.progressWindow.isHidden = true
            }
            
            if animated {
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 0.0
                } completion: { (_) in
                    block()
                }
            } else {
                block()
            }
//        }
    }
    
    func showSuccess(duration: TimeInterval = 3.0, title: String? = nil, completion: (() -> Void)? = nil) {
        show(title: title)
        progressView.isHidden = true
        iconImageView.isHidden = false
        iconImageView.image = #imageLiteral(resourceName: "pastStatusIcon").withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .pokemonPrimary

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.dismiss()
            self.progressView.isHidden = false
            self.iconImageView.isHidden = true
            completion?()
        }
    }
}
