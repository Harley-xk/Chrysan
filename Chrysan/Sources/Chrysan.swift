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
        view.setupAnimations()
        return view
    }
    
    private func setupAnimations() {
        showingAnimations = { [unowned self] in
            self.backgroundColor = .black
        }
        hidingAnimations = { [unowned self] in
            self.backgroundColor = .clear
        }
    }
    
    // MARK: - Status
    
    public var status: Status = .idle
    
    /// a vender provides status views for specified status
    public var statusViewVender: StatusViewVender = HUDViewVender()
    
    /// current status view
    private weak var currentStatusView: StatusView?
    
    public func changeStatus(to newStatus: Status, message: String? = nil) {
        
        guard newStatus != status, let superview = superview else {
            return
        }
        
        let animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
        if status == .idle {
            // show
            superview.bringSubviewToFront(self)
            isHidden = false
            if let showingAnimations = self.showingAnimations {
                animator.addAnimations(showingAnimations)
            }
        } else if newStatus == .idle {
            // hide
            if let hidingAnimations = self.hidingAnimations {
                animator.addAnimations(hidingAnimations)
            }
            animator.addCompletion { (position) in
                guard position == .end else { return }
                self.isHidden = true
                superview.sendSubviewToBack(self)
            }
        }
        
        if let statusView = currentStatusView, statusView.shouldResponse(to: status, for: self) {
            statusView.chrysan(self, willChangeTo: status, message: message, animator: animator)
        } else {
            currentStatusView?.removeFromSuperview()
            currentStatusView = statusViewVender.layoutView(in: self, for: status, message: message, animator: animator)
        }
        
        animator.startAnimation()
        status = newStatus
    }
    
    // MARK: - Animations
    
    public typealias AnimationTask = () -> Void
    public typealias AnimationComplection = (UIViewAnimatingPosition) -> Void
    
    open var showingAnimations: AnimationTask?
    open var showingComplection: AnimationComplection?
    open var hidingAnimations: AnimationTask?
    open var hddingComplection: AnimationComplection?
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
