//
//  ProfileDataStore.swift
//  HealthKitRunThrough
//
//  Created by Preston Perriott on 6/19/18.
//  Copyright © 2018 Preston Perriott. All rights reserved.
//

import Foundation
import HealthKit

class ProfileDataStore {
    
    class func getAgeSexBloodType() throws -> (age: Int, sex: HKBiologicalSex, bloodType: HKBloodType) {
     
        let healthStore = HKHealthStore()
        if (HKHealthStore.isHealthDataAvailable()) {
            print("Available")
            print(HKHealthStore.biologicalSex(healthStore))
        }
    
        
        do {
            /// Will throw error if data not avail
            let birthComp = try healthStore.dateOfBirthComponents()
            let sex = try healthStore.biologicalSex()
            let bloodType = try healthStore.bloodType()
            
            /// Calc of age
            let today = Date()
            let calendar = Calendar.current
            let dateComp = calendar.dateComponents([.year], from: today)
            
            let thisYear = dateComp.year!
            let age = thisYear - birthComp.year!
            
            /// Getting underlying enum values
            let unwrappedSex = sex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
            
            return(age, unwrappedSex, unwrappedBloodType)
        } catch {
            print("Our error is \(error.localizedDescription)")
            throw error
        }
    }
}
