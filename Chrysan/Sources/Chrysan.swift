//
//  Chrysan.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/1.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class Chrysan: UIView {
    
    // MARK: - Initialize
    
    /// 为指定的视图创建菊花
    public static func make(for targetView: UIView) -> Chrysan {
        let view = Chrysan()
        view.fill(in: targetView)
        return view
    }
    
    /// 移动到新的 target 视图
    public func move(to newTarget: UIView) {
        let view = self
        view.removeFromSuperview()
        view.fill(in: newTarget)
    }
    
    // MARK: - Status
    
    public var status: Status = .idle
    
    /// a vender provides status views for specified status
    public var statusViewVender: StatusViewVender = HUDViewVender()
    
    /// current status view
    private weak var currentStatusView: StatusView?
    
    public func changeStatus(to newStatus: Status, message: String? = nil) {
        
        if newStatus == .idle, status != .idle {
            currentStatusView?.chrysan(self, willEnd: status, finished: {
                self.currentStatusView?.removeFromSuperview()
                self.currentStatusView = nil
                
                // MARK: TODO: hide chrysan
                self.isHidden = true
                self.superview?.sendSubviewToBack(self)
            })
            status = .idle
            return
        }
        
        let shouldChangeView = statusViewVender.shoudChangeView(from: status, to: newStatus)
        if shouldChangeView || currentStatusView == nil {
            if let current = currentStatusView {
                current.chrysan(self, willEnd: status) {
                    current.removeFromSuperview()
                }
            }
            currentStatusView = statusViewVender.layoutView(in: self, for: newStatus, message: message)
        }
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        currentStatusView?.chrysan(self, changeTo: newStatus, message: message)
    }
}

// MARK: - Layout
extension Chrysan {
    
    func fill(in target: UIView) {
        target.addSubview(self)
        let layoutGuide = target.safeAreaLayoutGuide
        self.snp.makeConstraints {
            $0.left.equalTo(layoutGuide.snp.left)
            $0.right.equalTo(layoutGuide.snp.right)
            $0.top.equalTo(layoutGuide.snp.top)
            $0.bottom.equalTo(layoutGuide.snp.bottom)
        }
    }
}

// MARK: - StatusView
extension Chrysan {
    
    func layoutStatusView(view: StatusView, width layout: Layout) {
        addSubview(view)
        view.snp.removeConstraints()
        view.snp.makeConstraints {
            $0.edges.greaterThanOrEqualToSuperview().inset(layout.padding)
            $0.size.greaterThanOrEqualTo(layout.minSize)
            switch layout.position {
            case .center:
                $0.centerX.equalToSuperview().offset(layout.offset.x)
                $0.centerY.equalToSuperview().offset(layout.offset.y)
            case .top:
                $0.top.equalToSuperview().offset(layout.offset.y)
                $0.centerX.equalToSuperview().offset(layout.offset.x)
            case .bottom:
                $0.bottom.equalToSuperview().offset(layout.offset.y)
                $0.centerX.equalToSuperview().offset(layout.offset.x)
            case .fill:
                $0.edges.equalToSuperview().priority(.high)
            }
        }
    }
}


public extension UIView {
    
    var chrysan: Chrysan {
        // DO NOT try to get Chrysan from it's self!
        if self is Chrysan {
            fatalError("DO NOT try to get Chrysan from it's self!")
        }
        
        if let chrysan = subviews.first(where: { $0 is Chrysan }) as? Chrysan {
            return chrysan
        } else {
            return Chrysan.make(for: self)
        }
    }
}
