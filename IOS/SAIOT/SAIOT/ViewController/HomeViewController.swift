//
//  HomeViewController.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 4..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import SwiftyHue

class HomeViewController: UIViewController {
    
    // MARK: - Variable
    private var isSubView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlet Action Method
    @IBAction func ShowDetailHueMent(_ sender: UILongPressGestureRecognizer) {
        
        if (isSubView == false) {
            
            UIView.animate(withDuration: 1, animations: {
                
                let detailView = UINib(nibName: "DetailHue", bundle: nil).instantiate(withOwner: self, options: nil).first as! DetailHue
                detailView.delegate = self
                detailView.center = self.view.center
                self.view.addSubview(detailView)
            }, completion: nil)
            
            isSubView = true
        }
        
    }
}

// MAKR: - DetailHue Delegate Extension
extension HomeViewController: DetailHueDelegate {
    
    func closeSubView() {
        isSubView = false
    }
}
