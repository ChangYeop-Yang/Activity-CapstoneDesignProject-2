//
//  WhisperToast.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 18..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import Whisper

// MARK: - Method
internal func showWhisperToast(title: String, background: UIColor, textColor: UIColor) {
    
    var message: Murmur = Murmur(title: title)
    message.backgroundColor = background
    message.titleColor = textColor
    message.font = .boldSystemFont(ofSize: 11)
    
    Whisper.show(whistle: message, action: .show(1))
}

internal func showWhisperToast(title: String, background: UIColor, textColor: UIColor, clock: Int) {
    
    var message: Murmur = Murmur(title: title)
    message.backgroundColor = background
    message.titleColor = textColor
    message.font = .boldSystemFont(ofSize: 11)
    
    Whisper.show(whistle: message, action: .show(10))
}
