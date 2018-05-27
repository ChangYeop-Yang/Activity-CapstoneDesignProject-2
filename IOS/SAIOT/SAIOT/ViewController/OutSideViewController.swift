//
//  OutSideViewController.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 3. 29..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import AudioToolbox

class OutSideViewController: UIViewController {
    
    // MARK: - Variable
    private let socketServerPort: UInt32 = 8090
    private var isSelected: (video: Bool, socket: Bool) = (false, false)
    private let shapeLayer: CAShapeLayer = CAShapeLayer()
    
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
    @IBOutlet weak var stateCircle: UIButton! {
        didSet {
            shapeLayer.path = UIBezierPath(arcCenter: stateCircle.center, radius: outsideCircle.layer.cornerRadius, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
            shapeLayer.strokeColor = UIColor.lightcoral.cgColor
            shapeLayer.lineWidth = 10
            shapeLayer.lineCap = kCALineCapRound
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeEnd = 0
            outsideCircle.layer.addSublayer(shapeLayer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction Method
    @IBAction func conntrolRemoteVideo(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.0, animations: { [unowned self] in
            if let liveCamera = UINib(nibName: NibName.LiveCamera.rawValue, bundle: nil).instantiate(withOwner: self, options: nil).first as? LiveCamera {
                liveCamera.center = self.view.center
                self.view.addSubview(liveCamera)
            }
        })
    }
    @IBAction func controlConnect(_ sender: UIButton) {
        
        if isSelected.socket {
            isSelected.socket = SocketManager.socketManager.disconnect()
            sender.setTitle("서버 연결", for: .normal)
            sender.setImage(#imageLiteral(resourceName: "icons8-connected-50"), for: .normal)
        } else {
            if let serverURL: String = userDefaults.string(forKey: DefaultsKey.SocketAddressKey.rawValue) {
                isSelected.socket = SocketManager.socketManager.connect(address: serverURL, port: socketServerPort)
                sender.setTitle("서버 끊기", for: .normal)
                sender.setImage(#imageLiteral(resourceName: "icons8-disconnected-50"), for: .normal)
            }
        }
    }
    @IBAction func showState(_ sender: UIButton) {
        
        AudioServicesPlayAlertSound(4095)
    
        // Inner Circle Animation
        UIView.animate(withDuration: 2, animations: { [unowned self] in
            
            // Outside Circle Animation
            let basicAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.toValue = 1
            basicAnimation.duration = 2
            basicAnimation.fillMode = kCAFillModeForwards
            basicAnimation.isRemovedOnCompletion = false
            self.shapeLayer.add(basicAnimation, forKey: "Basic")
            
            sender.backgroundColor = (sender.backgroundColor == UIColor.springgreen ? UIColor.blanchedalmond : UIColor.springgreen)
            }, completion: { [unowned self] animated in
                
                if self.isSelected.socket && sender.backgroundColor == UIColor.springgreen {
                    SocketManager.socketManager.sendData(datas: "MOBILE:LOCK")
                    showWhisperToast(title: "Smart PostBox Lock", background: .moss, textColor: .white)
                } else if self.isSelected.socket {
                    SocketManager.socketManager.sendData(datas: "MOBILE:DISABLE")
                    showWhisperToast(title: "Smart PostBox UnLock", background: .maroon, textColor: .white)
                }
        })
    }
}
