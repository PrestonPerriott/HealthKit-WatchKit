//
//  WatchDataProvider.swift
//  HealthKitRunThrough
//
//  Created by Preston Perriott on 6/19/18.
//  Copyright © 2018 Preston Perriott. All rights reserved.
//

import WatchConnectivity
import UIKit
import CoreBluetooth

/// https://stackoverflow.com/questions/32574961/using-wcsession-with-more-than-one-viewcontroller

class WatchDataProvider: NSObject {
    
    fileprivate var session: WCSession?
    static var activated: Bool = false
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
            WatchDataProvider.activated = true
        }
    }
}

extension WatchDataProvider: WCSessionDelegate {
    /// MARK: - WCSESSIONDELEGATE
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        if (session.isPaired) {
            if (session.isWatchAppInstalled) {
            /// basic check
            print("We've got a valid connection")
            }
        }
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    public func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        print("app Context is : \(applicationContext)")
        processIncomingMessage(dict: applicationContext)
    }
    
    public func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        
        print("User info is  : \(userInfo)")
        processIncomingMessage(dict: userInfo)
    }
    
    func processIncomingMessage(dict: [String:Any]) {
        DispatchQueue.main.async(execute: {
            /// Update main queue with pertinent info
            print("Our info or Context is : \(dict)")
        })
    }
}

/// Might want to add functionality for a Bluetooth Handler


