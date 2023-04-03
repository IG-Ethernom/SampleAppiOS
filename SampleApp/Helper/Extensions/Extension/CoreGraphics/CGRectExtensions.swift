//
//  CGRectExtensions.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/4/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit

public extension CGRect {
    /// 返回指定大小和显示模式下的区域
    ///
    /// - Parameters:
    ///   - size: 原始尺寸
    ///   - mode: 显示模式
    /// - Returns: 区域范围
    func rectFit(size: CGSize, mode: UIView.ContentMode) -> CGRect {
        var mSize = size
        var cGrect = self
        mSize.width = mSize.width < 0 ? -mSize.width : mSize.width
        mSize.height = mSize.height < 0 ? -mSize.height : mSize.height
        let center = CGPoint(x: midX, y: midY)
        switch mode {
        case .scaleAspectFit, .scaleAspectFill:
            if cGrect.size.width < 0.01 || cGrect.size.height < 0.01 || mSize.width < 0.01 || mSize.height < 0.01 {
                cGrect.origin = center
                cGrect.size = CGSize.zero
            } else {
                var scale: CGFloat = 0
                if mode == .scaleAspectFit {
                    if mSize.width / mSize.height < cGrect.size.width / cGrect.size.height {
                        scale = cGrect.size.height / mSize.height
                    } else {
                        scale = cGrect.size.width / mSize.width
                    }
                } else {
                    if mSize.width / mSize.height < cGrect.size.width / cGrect.size.height {
                        scale = cGrect.size.width / mSize.width
                    } else {
                        scale = cGrect.size.height / mSize.height
                    }
                }
                mSize.width *= scale
                mSize.height *= scale
                cGrect.size = mSize
                cGrect.origin = CGPoint(x: center.x - mSize.width * 0.5, y: center.y - mSize.height * 0.5)
            }
        case .center:
            cGrect.size = mSize
            cGrect.origin = CGPoint(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5)
        case .top:
            cGrect.origin.x = center.x - mSize.width * 0.5
            cGrect.size = mSize
        case .bottom:
            cGrect.origin.x = center.x - mSize.width * 0.5
            cGrect.origin.y += cGrect.size.height - mSize.height
            cGrect.size = mSize
        case .left:
            cGrect.origin.y = center.y - size.height * 0.5
            cGrect.size = mSize
        case .right:
            cGrect.origin.y = center.y - size.height * 0.5
            cGrect.origin.x += cGrect.size.width - mSize.width
            cGrect.size = mSize
        case .topLeft:
            cGrect.size = mSize
        case .topRight:
            cGrect.origin.x += cGrect.size.width - size.width
            cGrect.size = size
        case .bottomLeft:
            cGrect.origin.y += cGrect.size.height - mSize.height
            cGrect.size = mSize
        case .bottomRight:
            cGrect.origin.x += cGrect.size.width - mSize.width
            cGrect.origin.y += cGrect.size.height - mSize.height
            cGrect.size = mSize
        default:
            cGrect = self
        }
        return cGrect
    }
}
