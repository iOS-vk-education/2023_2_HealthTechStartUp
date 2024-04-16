//
//  HealthService.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//

import Foundation
import HealthKit

final class HealthService {
    
    let healthStore = HKHealthStore()
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let distance = HKQuantityType(.distanceWalkingRunning)
        let activeEnergyBurned = HKQuantityType(.activeEnergyBurned)
        let flightsClimbed = HKQuantityType(.flightsClimbed)
        let heartRate = HKQuantityType(.heartRate)
        
        let healthTypes: Set = [steps, distance, activeEnergyBurned, flightsClimbed, heartRate]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print(error)
            }
        }
    }
    
    func isHealthKitAvaible() -> Bool {
        if HKHealthStore.isHealthDataAvailable() {
            return true
        } else {
            return false
        }
    }
    
    func checkAuthorizationStatus(for types: Set<HKObjectType>, completion: @escaping (Bool) -> Void) {
        for healthType in types {
            healthStore.authorizationStatus(for: healthType)
        }
    }

    func getStepCount(startDate: Date, endDate: Date, completion: @escaping (String, Error?) -> Void) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion("0", nil)
            return
        }
//        
//        let startDate = Calendar.current.startOfDay(for: Date())
//        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion("0", error)
                return
            }
            
            let stepCount = Int(sum.doubleValue(for: HKUnit.count()))
            let stepCountFormatted = String(stepCount)
            completion(stepCountFormatted, nil)
        }
        
        healthStore.execute(query)
    }
    
    func getDistance(startDate: Date, endDate: Date, completion: @escaping (String, Error?) -> Void) {
        guard let distance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            completion("0", nil)
            return
        }
        
//        let startDate = Calendar.current.startOfDay(for: Date())
//        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: distance,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion("0", error)
                return
            }
            
            let distance = (sum.doubleValue(for: HKUnit.meter()) / 10).rounded() / 100
            let distanceformatted = String(distance)
            completion(String(distanceformatted), nil)
        }
        
        healthStore.execute(query)
    }
    
    func getActiveEnergyBurned(startDate: Date, endDate: Date, completion: @escaping (String, Error?) -> Void) {
        guard let activeEnergyBurned = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion("0", nil)
            return
        }
        
//        let startDate = Calendar.current.startOfDay(for: Date())
//        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: activeEnergyBurned,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion("0", error)
                return
            }
            
            let energyBurnedInKcal = (sum.doubleValue(for: HKUnit.kilocalorie()) * 100).rounded() / 100
            let energyBurnedInKcalFormatted = String(energyBurnedInKcal)
            completion(energyBurnedInKcalFormatted, nil)
        }
        
        healthStore.execute(query)
    }
    
    func getFlightsClimbed(startDate: Date, endDate: Date, completion: @escaping (String, Error?) -> Void) {
        guard let flightsClimbedType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            completion("0", nil)
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: flightsClimbedType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion("0", error)
                return
            }
            
            let flightsClimbed = (sum.doubleValue(for: HKUnit.count()) * 100).rounded() / 100
            let flightsClimbedFormatted = String(flightsClimbed)
            completion(flightsClimbedFormatted, nil)
        }
        
        healthStore.execute(query)
    }
    
    func getAverageHeartRate(startDate: Date, endDate: Date, completion: @escaping (String, Error?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion("0", nil)
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            if let result = result, let averageHeartRate = result.averageQuantity() {
                let beatsPerMinute = averageHeartRate.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                let beatsPerMinuteFormatted = String(format: "%.2f", beatsPerMinute)
                completion(beatsPerMinuteFormatted, nil)
                print("Средний пульс за последние N часов: \(beatsPerMinute) ударов в минуту")
            } else {
                completion("Error", error)
                print("Ошибка при получении данных о пульсе: \(String(describing: error))")
            }
        }
        healthStore.execute(query)
    }
}
