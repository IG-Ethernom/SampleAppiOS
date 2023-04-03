//
//  CustomImageView.swift
//  Release Stress
//
//  Created by Puttheavy tep on 2/2/2566 BE.
//

import UIKit
import SDWebImage

class CustomImageView: UIImageView {
    
    func loadImageUsingUrlStrings(urlString: String) {
        layer.masksToBounds = true
        setCornerRadious()
        contentMode = .scaleAspectFill
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.5
        
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.sd_setImage(with: url, placeholderImage: UIImage(named: "Gray"))
                self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            }
        }
    }
    
    
    
    
}
