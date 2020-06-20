//
//  PaperViewController.swift
//  microprogram
//
//  Created by Chris on 2020/6/19.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class PaperViewController: UIViewController , ObservedProtocol{
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    var subscribeConnectionHandler0: SubscribeConnectionHandler?
    var subscribeConnectionHandler1: SubscribeConnectionHandler?
    var subscribeConnectionHandler2: SubscribeConnectionHandler?
    
    let statusKey: StatusKey = StatusKey.subscribeStatusKey
    let notification: Notification.Name = .subscribeConnection
    
    @IBAction func subscribe(_ sender: Any) {
        let swtich:UISwitch = sender as! UISwitch
        
        if swtich.isOn {
            notifyObservers(about: SubscribeConnectionStatus.connected.rawValue)
        }
        else {
            notifyObservers(about: SubscribeConnectionStatus.disconnected.rawValue)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeConnectionHandler0 = SubscribeConnectionHandler(label: firstLabel)
        subscribeConnectionHandler1 = SubscribeConnectionHandler(label: secondLabel)
        subscribeConnectionHandler2 = SubscribeConnectionHandler(label: thirdLabel)
    }
    
}
