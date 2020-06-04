//
//  DetailViewController.swift
//  Example
//
//  Created by Harley-xk on 2020/6/1.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import Chrysan
import Comet

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func showAction(_ sender: Any) {
        
    }
    
}

