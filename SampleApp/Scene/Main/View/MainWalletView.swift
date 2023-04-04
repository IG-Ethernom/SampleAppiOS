//
//  MainWalletView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 29/3/2566 BE.
//

import UIKit

class MainWalletView: BaseView {
    
    override func setupView() {
        let sView = [tableView]
        addSubviews(sView)
        
        NSLayoutConstraint.activate([
          
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
  
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        return table
    }()
    
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


//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(for: indexPath) as MainCollectViewCells
        cell.layer.cornerRadius = 15
        cell.backgroundColor = .init(hexString: .colorPrimary)
        
       // cell.layer.borderWidth = 1
        // cell.layer.borderColor = UIColor.init(hexString: .colorPrimary).cgColor
        
        
        let item = featureItem[indexPath.row]
        cell.titleLabel.text = item.name
        cell.imageThumnail.image = UIImage(named: item.icon)
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-30)/2
        return CGSize(width: width, height: 120)
    }
}
//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // delegate?.openVideoController(data: element, index: indexPath)
        operateFeature(item: featureItem[indexPath.row])
    }
    
    
}
