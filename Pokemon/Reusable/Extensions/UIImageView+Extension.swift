//
//  UIImageView+Extension.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//
import UIKit
import Foundation
import Alamofire
import AlamofireImage

extension UIImageView {
    func setImage(with suposedURL: URLConvertible?, placeholderImage: UIImage? = nil, progressHandler: ImageDownloader.ProgressHandler? = nil, completion: ((Result<UIImage, AFIError>) -> Void)? = nil) {
        
        guard let suposedURL = suposedURL else {
            image = placeholderImage
            return
        }
        do {
            let url = try suposedURL.asURL()
            
            self.af.setImage(
                withURL: url,
                placeholderImage: placeholderImage,
                progress: progressHandler,
                progressQueue: DispatchQueue.main,
                imageTransition: ImageTransition.crossDissolve(0.1),
                runImageTransitionIfCached: false) {[weak self] (response) in
                switch response.result {
                case .success(let image):
                    completion?(.success(image))
                case .failure(let afiError):
                    self?.image = placeholderImage
                    completion?(.failure(afiError))
                }
                completion?(response.result)
            }
        } catch let error {
            image = placeholderImage
            print(error)
        }
    }
}
