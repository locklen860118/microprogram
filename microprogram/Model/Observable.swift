//
//  Observable.swift
//  microprogram
//
//  Created by Chris on 2020/6/19.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

//定義通知
extension Notification.Name {
    static let subscribeConnection = Notification.Name("subscribeConnection")
}

//定義訂閱狀態
enum SubscribeConnectionStatus: String {
    case connected
    case disconnected
    case error
}

// 定義userInfo的key值
enum StatusKey: String {
    case subscribeStatusKey
}

// 定義觀察者的基本結構
protocol ObserverProtocol {
    var statusValue: String { get set }
    var statusKey: String { get }
    var notificationOfInterest: Notification.Name { get }
    func subscribe()
    func unsubscribe()
    func handleNotification()
}

// 被觀察者通過此方法在接收到通知時進行操作
class Observer: ObserverProtocol {

    var statusValue: String
    
    let statusKey: String //userInfo的key
    let notificationOfInterest: Notification.Name
    
    // 初始化notification和被觀察者(statuskey)的key值
    init(statusKey: StatusKey, notification: Notification.Name) {
        
        self.statusValue = "123"
        self.statusKey = statusKey.rawValue
        self.notificationOfInterest = notification
        
        subscribe()
    }
    
    // 向 NotificationCenter 註冊 self(this) 來接收所有儲存在 notificationOfInterest 中的通知。
    // 接收到任意一個註冊的通知時，會呼叫 receiveNotification(_:) 方法。
    func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(_:)), name: notificationOfInterest, object: nil)
    }
    // 刪除
    func unsubscribe() {
        NotificationCenter.default.removeObserver(self, name: notificationOfInterest, object: nil)
    }
    
    // 在任意一個 notificationOfInterest 所定義的通知接收到時呼叫
    // 根據所觀察的條件改變進行操作
    @objc func receiveNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo, let status = userInfo[statusKey] as? String {
            
            statusValue = status
            handleNotification()
        }
    }
    
    func handleNotification() {
       //準備給label改顏色用
    }
    // 析構時取消對Notification的關聯，已經不需要進行觀察
    deinit {
        print("Observer unsubscribing from notifications.")
        unsubscribe()
    }
}

// 被觀察者，狀態發生改變時會通知給所有訂閱者
protocol ObservedProtocol {
    var statusKey: StatusKey { get }
    var notification: Notification.Name { get }
    func notifyObservers(about changeTo: String) -> Void
}

// 向所有訂閱者廣播
extension ObservedProtocol {
    func notifyObservers(about changeTo: String) -> Void {
        NotificationCenter.default.post(name: notification, object: self, userInfo: [statusKey.rawValue : changeTo])
    }
    
}
