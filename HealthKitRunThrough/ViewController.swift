//
//  ViewController.swift
//  HealthKitRunThrough
//
//  Created by Preston Perriott on 6/15/18.
//  Copyright © 2018 Preston Perriott. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    private func authorizeHelathKit() {
        
        HealthKitSetupAssistant.authHealthKit { (auth, error) in
            guard auth else {
                let baseMessage = "Healthkit Auth Failed"
                if let error = error {
                    print("\(baseMessage). reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            print("Health Kit auth.")
        }
    }
    
    private func asyncUpdate(completion: @escaping (Error?) -> Void) {
        updateWatchData()
        completion(nil)
    }
    
    private func updateWatchData() {
        
        var lastMessageTime: CFAbsoluteTime = 0
        let currTime = CFAbsoluteTimeGetCurrent()
        
        if lastMessageTime + 0.5 > currTime {
            return    //Don't want to keep forcing messages
            //So we return if less than half a second has passed
        }
        
        //if the watch is there, we can send a message
      //  if WCSession.default.isReachable {
            
            do {
                let profileData = try ProfileDataStore.getAgeSexBloodType()
                let message = ["HealthData": "hi"]
                print("Our User Age data from HealthKit : \(profileData.age)")
                WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
                
            } catch let error {
                /// Need to handle thrown error
                print("Our localized error is  \(error.localizedDescription)")
            }
            
            lastMessageTime = CFAbsoluteTimeGetCurrent()
       // }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHelathKit()
        
        asyncUpdate { (err) in
            if let error = err {
                print("There was an error: \(error.localizedDescription)")
            } else {
                print("The watch data has been sent.")
            }
        }
    }
    
    
    
}

