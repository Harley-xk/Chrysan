//
//  RingProgressView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/5.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

public typealias ProgressCompatiableView = UIView & StatusResponsable

class RingProgressView: ProgressCompatiableView {
    func chrysan(_ chrysan: Chrysan, changeTo status: Status, message: String?) {
        
    }
    
    func chrysan(_ chrysan: Chrysan, willEnd status: Status, finished: @escaping () -> ()) {
        
    }
    
    
    func update(percent: Double) {
        
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
