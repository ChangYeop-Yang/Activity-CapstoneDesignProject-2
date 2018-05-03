//
//  DetailHue.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 17..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit

// MARK: - Enum
private enum SliderTag: Int {
    case RED = 100
    case GREEN = 200
    case BLUE = 300
    case ALPHA = 400
}

// MARK: - Delegate
internal protocol DetailHueDelegate: class {
    func closeSubView()
}

class DetailHue: UIView {

    // MARK: - Outlet Variable
    @IBOutlet weak var redSlider: UISlider! {
        didSet { redSlider.isContinuous = false }
    }
    @IBOutlet weak var greenSlider: UISlider! {
        didSet { greenSlider.isContinuous = false }
    }
    @IBOutlet weak var blueSlider: UISlider! {
        didSet { blueSlider.isContinuous = false }
    }
    @IBOutlet weak var alphaSlider: UISlider! {
        didSet { alphaSlider.isContinuous = false }
    }
    
    // MARK: - Variable
    internal weak var delegate: DetailHueDelegate?
    private var hueColors: (RED: Int, GREEN: Int, BLUE: Int, ALPHA: Int) = (100, 100, 100, 200)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setting BaseView Radius
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }
    
    // MARK: - Outlet Action Method
    @IBAction func changeColorValue(_ sender: UISlider) {
        
        let sliderTag: SliderTag = SliderTag(rawValue: sender.tag)!
        switch sliderTag {
            case .RED: hueColors.RED        = Int(sender.value)
            case .GREEN: hueColors.GREEN    = Int(sender.value)
            case .BLUE: hueColors.BLUE      = Int(sender.value)
            case .ALPHA: hueColors.ALPHA    = Int(sender.value)
        }
        
        PhilipsHueBridge.hueInstance.changeHueColor(red: hueColors.RED, green: hueColors.GREEN, blue: hueColors.BLUE, alpha: hueColors.ALPHA)
    }
    @IBAction func cancleNib(_ sender: UIButton) {
        delegate?.closeSubView()
        self.removeFromSuperview()
    }
}
