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
    public static func make(
        for targetView: UIView,
        responder: StatusResponder = HUDResponder()
    ) -> Chrysan {
        let view = Chrysan()
        view.responder = responder
        view.fill(in: targetView)
        view.isHidden = true
        return view
    }
    
    // MARK: - Status
    
    public var status: Status = .idle
    
    /// a vender provides status views for specified status
    public private(set) var responder: StatusResponder = HUDResponder()
    
    /// 更新 Status
    /// - Parameter newStatus: 新的状态
    public func changeStatus(to newStatus: Status) {

        guard let _ = superview else {
            return
        }
        
        if newStatus != .idle, isHidden {
            isHidden = false
        }
        
        responder.changeStatus(from: status, to: newStatus, for: self) {
            self.didChangeStatus(to: newStatus)
        }
    }
    
    private func didChangeStatus(to newStatus: Status) {
        self.status = newStatus
        
        if newStatus == .idle {
            self.isHidden = true
        }
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
