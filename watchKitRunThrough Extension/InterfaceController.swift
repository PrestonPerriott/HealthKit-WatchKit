//
//  InterfaceController.swift
//  watchKitRunThrough Extension
//
//  Created by Preston Perriott on 6/19/18.
//  Copyright © 2018 Preston Perriott. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


/// Like our apps regular ViewController
class InterfaceController: WKInterfaceController {
    
    @IBOutlet var restingHeartRate: WKInterfaceLabel!
    @IBOutlet var heartRateActivityRing: WKInterfaceActivityRing!
    
    /// Basic did set for our this views session
    var watchSession: WCSession? {
        didSet {
            if let session = watchSession {
                session.delegate = self
                session.activate()
            }
        }
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        watchSession = WCSession.default
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

extension InterfaceController: WCSessionDelegate {
   
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        /// Should call something here to notify app
        print("Sessionwas connected to phone")
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        /// What we really care about, our returned dict from the app
        print("Our application Context from the phone is : ", applicationContext);
    }
}
