//
//  RefreshView.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/19/20.
//  Copyright © 2020 Chhany. All rights reserved.
//
import MJRefresh
class RefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        var images = [UIImage]()
        for index in 0..<10 {
            if let image = UIImage(named: "refresh_loading0\(index)") {
                images.append(image)
            }
        }
        setImages(images, for: .idle)
        setImages(images, for: .pulling)
        setImages(images, for: .refreshing)
        setTitle("", for: .idle)
        setTitle("", for: .pulling)
        setTitle("", for: .refreshing)
    }
    override func placeSubviews() {
        super.placeSubviews()
        gifView?.contentMode = .center
        gifView?.frame = CGRect(x: 0, y: 4, width: mj_w, height: 25)
        stateLabel?.font = UIFont.systemFont(ofSize: 12)
        stateLabel?.frame = CGRect(x: 0, y: 35, width: mj_w, height: 14)
    }
}
