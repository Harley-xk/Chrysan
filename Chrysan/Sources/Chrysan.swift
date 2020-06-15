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
        let layoutGuide = UILayoutGuide()
        target.addLayoutGuide(layoutGuide)
        target.addSubview(self)
        self.snp.makeConstraints {
            $0.left.equalTo(layoutGuide.snp.left)
            $0.top.equalTo(layoutGuide.snp.top)
            $0.size.equalToSuperview()
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
