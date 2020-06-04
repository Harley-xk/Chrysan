//
//  ChrysanMaskView.swift
//  Chrysan
//
//  Created by Harley-xk on 2020/6/4.
//  Copyright © 2020 Harley. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ChrysanMaskView: UIView {
    
    var manager: Chrysan?
    
    func fill(in target: UIView) {
        target.addSubview(self)
        self.snp.makeConstraints {
            $0.left.equalTo(target.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(target.safeAreaLayoutGuide.snp.right)
            $0.top.equalTo(target.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(target.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
