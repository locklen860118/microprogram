//
//  LabelColor.swift
//  microprogram
//
//  Created by Chris on 2020/6/19.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

// 當switch改變後要做的事
class SubscribeConnectionHandler: Observer {
    
    var myLabel: UILabel
    
    init(label: UILabel) {
        
        self.myLabel = label
        
        super.init(statusKey: .subscribeStatusKey, notification: .subscribeConnection)
    }
    
    // 改變label顏色
    override func handleNotification() {
        
        if statusValue == SubscribeConnectionStatus.connected.rawValue {
            myLabel.textColor = UIColor.green
        }
        else {
            myLabel.textColor = UIColor.red
        }
    }
}
