//
//  MainWalletView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 29/3/2566 BE.
//

import UIKit

class MainWalletView: BaseView {
    
    override func setupView() {
        
        setupviewItem()
    }
    
    func setupviewItem () {
        addSubview(myCollectionView)
        myCollectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            myCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            myCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            myCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 5.0
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.showsVerticalScrollIndicator = false
        collectionview.isScrollEnabled = true
        return collectionview
    }()
}

