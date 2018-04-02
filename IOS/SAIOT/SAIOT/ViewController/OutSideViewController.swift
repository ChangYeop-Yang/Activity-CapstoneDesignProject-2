//
//  OutSideViewController.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 3. 29..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit

class OutSideViewController: UIViewController {

    // MARK: - Outlet Variable
    @IBOutlet weak var outsideCircle: UIView! {
        didSet {
            outsideCircle.layer.cornerRadius = outsideCircle.frame.size.width / 2
            outsideCircle.clipsToBounds = true
        }
    }
    @IBOutlet weak var innerCircle: UIView! {
        didSet {
            innerCircle.layer.cornerRadius = innerCircle.frame.size.width / 2
            innerCircle.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
