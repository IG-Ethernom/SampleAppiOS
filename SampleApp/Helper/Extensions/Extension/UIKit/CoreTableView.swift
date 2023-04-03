//
//  CoreTableView.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/19/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit
import MJRefresh

class CoreTableView: UITableView {
    var currentPage = 0
    func endRefreshHeader() {
        currentPage = 0
        self.mj_header?.endRefreshing()
    }
    func endRefreshFooter() {
        self.mj_footer?.endRefreshing()
    }
    func onMyLoadMore(success: @escaping (Int) -> Void) {
        let footer =  MJRefreshAutoNormalFooter {
            self.currentPage += 1
            success(self.currentPage)
        }
        footer.setTitle("", for: .idle)
        self.mj_footer = footer
    }
    func onRefresh(success: @escaping () -> Void) {
        let header = RefreshHeader {
            success()
        }
        header.lastUpdatedTimeLabel?.isHidden = true
        self.mj_header = header
    }
    func noData() {
        let footer = MJRefreshAutoNormalFooter {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
        footer.setTitle("", for: .noMoreData)
        self.mj_footer = footer
    }
}
