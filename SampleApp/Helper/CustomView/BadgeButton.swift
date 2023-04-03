//
//  BadgeButton.swift
//  TDC Tube
//
//  Created by Puttheavy tep on 2/3/2566 BE.
//

import Foundation
import UIKit

class BadgedButtonItem: UIBarButtonItem {

    public func setBadge(with value: Int) {
        self.badgeValue = value
    }

    private var badgeValue: Int? {
        didSet {
            if let value = badgeValue,
                value > 0 {
                lblBadge.isHidden = false
                lblBadge.text = "\(value)"
            } else {
                lblBadge.isHidden = true
            }
        }
    }

    var tapAction: (() -> Void)?

    private let filterBtn = UIButton()
    private let lblBadge = UILabel()

    override init() {
        super.init()
        setup()
    }

    init(with image: UIImage?) {
        super.init()
        setup(image: image)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(image: UIImage? = nil) {

        self.filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.filterBtn.adjustsImageWhenHighlighted = false
        self.filterBtn.setImage(image, for: .normal)
        self.filterBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        self.lblBadge.frame = CGRect(x: 20, y: 0, width: 15, height: 15)
        self.lblBadge.backgroundColor = .red
        self.lblBadge.clipsToBounds = true
        self.lblBadge.layer.cornerRadius = 7
        self.lblBadge.textColor = UIColor.white
        self.lblBadge.font = UIFont.systemFont(ofSize: 10)
        self.lblBadge.textAlignment = .center
        self.lblBadge.isHidden = true
        self.lblBadge.minimumScaleFactor = 0.1
        self.lblBadge.adjustsFontSizeToFitWidth = true
        self.filterBtn.addSubview(lblBadge)
        
        self.customView = filterBtn
    }

    @objc func buttonPressed() {
        if let action = tapAction {
            action()
        }
    }

    func setupBadge() {
        
        let filterBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        filterBtn.setImage(UIImage(named: "notification"), for: .normal)
      
        let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
        lblBadge.backgroundColor = .red
        lblBadge.clipsToBounds = true
        lblBadge.layer.cornerRadius = 7
        lblBadge.textColor = UIColor.white
        lblBadge.textAlignment = .center
        lblBadge.text = "1"

        filterBtn.addSubview(lblBadge)
     //   self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: filterBtn)]

    }
}

extension UIBarButtonItem {
        
    convenience init(icon: UIImage, badge: String, _ badgeBackgroundColor: UIColor = #colorLiteral(red: 0.9156965613, green: 0.380413115, blue: 0.2803866267, alpha: 1), target: Any? = UIBarButtonItem.self, action: Selector? = nil) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.image = icon

        let label = UILabel(frame: CGRect(x: 12, y: -10, width: 18, height: 18))
        label.text = badge
        label.backgroundColor = badgeBackgroundColor
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.clipsToBounds = true
        label.layer.cornerRadius = 18 / 2
        label.textColor = .white

        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        buttonView.addGestureRecognizer(UITapGestureRecognizer.init(target: target, action: action))
        self.init(customView: buttonView)
    }
    
}
