//
//  LoadingView.swift
//  ContactTracing
//
//  Created by IG Group on 21/10/21.
//

import UIKit
class LoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(mainView)
        
        mainView.addSubview(stackView)
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.widthAnchor.constraint(equalToConstant: UIDevice.isIPad ? 250: UIScreen.main.bounds.width/2 + 20),
            mainView.heightAnchor.constraint(equalToConstant: 90),
            
            stackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var indcator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            loading.style = .medium
        } else {
            // Fallback on earlier versions
            loading.style = .medium
        }
        loading.color = .black
        loading.startAnimating()
        return loading
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let subStackView = UIStackView(arrangedSubviews: [indcator,titleLabel])
        subStackView.axis = .vertical
        subStackView.distribution = .equalSpacing
        subStackView.spacing = 10
        subStackView.translatesAutoresizingMaskIntoConstraints = false
        return subStackView
    }()
}
