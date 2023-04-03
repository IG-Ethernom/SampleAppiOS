//
//  CustomLoginButton.swift
//  Release Stress
//
//  Created by Puttheavy tep on 26/1/2566 BE.
//

import UIKit
class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        titleFont = UIFont.NunitoFont_Regular(16)
    }
    
    func socialLogin(title: String, color: UIColor, raduis: CGFloat? = 30) {
        backgroundColor = color
        makeCorner(withRadius: raduis!)
        titleFont = UIFont.NunitoFont_Semibol(15)
        setTitle(title, for: .normal)
    }
}


final class CustomLoginButton: BaseView {
    
    override func setupView() {
        let subView = [myTitleLabel, myIconImage]
        addSubviews(subView)
        
        myIconImage.centerInSuperview(size: CGSize(width: 24, height: 24))
        myTitleLabel.centerInSuperview(x: 10)
    
    }
    
    let myTitleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: "Continue with Facebook")
        return label
    }()
    
    let myIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "facebook")
        imageView.tintColor = .white
        return imageView
    }()
    
}
