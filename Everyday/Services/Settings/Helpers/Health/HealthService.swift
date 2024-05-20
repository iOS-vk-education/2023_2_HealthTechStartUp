//
//  HealthService.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//

import Foundation
import HealthKit

protocol HealthServiceDescription {
    func fetchTodaySteps()
    func fetchTodayCalories()
    func fetchTodayDistance()
    func fetchAverageHeartRate()
    func fetchWeeklySteps()
    func fetchFlightClimbed()
    func fetchWeight(completion: @escaping (Result<Void, Error>, _ bodyMass: String?, _ measure: String?) -> Void)
    func fetchFatPercentage(completion: @escaping (Result<Void, Error>, _ fatPercent: String?) -> Void)
}

final class HealthService: ObservableObject, HealthServiceDescription {
    public static let shared = HealthService()
    
    private let healthStore = HKHealthStore()
    
    @Published var activities: [String: Activity] = [:]
    
    private init() {
        let steps = HKQuantityType(.stepCount)
        let distance = HKQuantityType(.distanceWalkingRunning)
        let activeEnergyBurned = HKQuantityType(.activeEnergyBurned)
        let flightsClimbed = HKQuantityType(.flightsClimbed)
        let heartRate = HKQuantityType(.heartRate)
        let bodyMass = HKQuantityType(.bodyMass)
        let bodyFatPercentage = HKQuantityType(.bodyFatPercentage)
        
        let healthTypes: Set = [steps, distance, activeEnergyBurned, flightsClimbed, heartRate, bodyMass, bodyFatPercentage]
        
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
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today steps")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0,
                                    title: "Progress.Steps.title".localized,
                                    timeInterval: "Progress.Today.title".localized,
                                    image: "figure.walk",
                                    amount: stepCount.formattedString() ?? "",
                                    measure: nil)
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today calories")
                return
            }
            
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: 1,
                                    title: "Progress.EnergyBurned.title".localized,
                                    timeInterval: "Progress.Today.title".localized,
                                    image: "flame",
                                    amount: caloriesBurned.formattedString() ?? "",
                                    measure: "Progress.Ccal.title".localized)
            DispatchQueue.main.async {
                self.activities["todayCalories"] = activity
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayDistance() {
        let distance = HKQuantityType(.distanceWalkingRunning)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        let query = HKStatisticsQuery(quantityType: distance, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today distance")
                return
            }
            
            let distanceWalkingRunning = quantity.doubleValue(for: .meter())
            
            let currentFormattedDistance = self.getMeasureForDistance(distance: distanceWalkingRunning)
            
            let activity = Activity(id: 2,
                                    title: "Progress.Distance.title".localized,
                                    timeInterval: "Progress.Today.title".localized,
                                    image: "ruler",
                                    amount: currentFormattedDistance.formattedDistance,
                                    measure: currentFormattedDistance.currentMeasure)
            DispatchQueue.main.async {
                self.activities["todayDistance"] = activity
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchAverageHeartRate() {
        let heartRate = HKQuantityType(.heartRate)
        
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date(), options: .strictEndDate)
        let query = HKStatisticsQuery(quantityType: heartRate, quantitySamplePredicate: predicate, options: .discreteAverage) { (_, result, error) in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today HeartRate")
                return
            }
            
            let beatsPerMinute = quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
            let beatsPerMinuteFormatted = String(format: "%.2f", beatsPerMinute)
            
            let activity = Activity(id: 3,
                                    title: "Progress.AverageHeartRate.title".localized,
                                    timeInterval: "Progress.Today.title".localized,
                                    image: "heart.square",
                                    amount: beatsPerMinuteFormatted,
                                    measure: "Progress.BeatPerMinute.title")
            DispatchQueue.main.async {
                self.activities["averageHeartRate"] = activity
            }
            print("Средний пульс за последние N часов: \(beatsPerMinute) ударов в минуту")
        }
        
        healthStore.execute(query)
    }
    
    func fetchWeeklySteps() {
        let steps = HKQuantityType(.stepCount)
        
        let calendar = Calendar.current
        let now = Date()
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) else {
            print("неделя не неделя")
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfWeek, end: now)
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching weekly steps")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 4,
                                    title: "Progress.Steps.title".localized,
                                    timeInterval: "Progress.ThisWeak.title".localized,
                                    image: "figure.walk",
                                    amount: stepCount.formattedString() ?? "",
                                    measure: nil)
            DispatchQueue.main.async {
                self.activities["weeklySteps"] = activity
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchFlightClimbed() {
        let flightsClimbed = HKQuantityType(.flightsClimbed)
        
        let calendar = Calendar.current
        let now = Date()
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) else {
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfWeek, end: now)
        
        let query = HKStatisticsQuery(quantityType: flightsClimbed, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching  flights")
                return
            }
            
            let flightsCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 5,
                                    title: "Progress.FlightsClimbed.title".localized,
                                    timeInterval: "Progress.ThisWeak.title".localized,
                                    image: "flame",
                                    amount: flightsCount.formattedString() ?? "",
                                    measure: "Progress.Flights.title".localized)
            
            DispatchQueue.main.async {
                self.activities["flightsClimbed"] = activity
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchWeight(completion: @escaping (Result<Void, Error>, _ bodyMass: String?, _ measure: String?) -> Void) {
        guard let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            completion(.failure(NSError(domain: "HealthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Weight type is unavailable"])), nil, nil)
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: weightType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, results, error in
            if let error = error {
                completion(.failure(error), nil, nil)
                print("Failed to fetch weight: \(error.localizedDescription)")
                return
            }
            
            guard let result = results?.first as? HKQuantitySample else {
                completion(.failure(NSError(domain: "HealthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No weight data available"])), nil, nil)
                print("No weight data available")
                return
            }
            
            let weightInKilograms = result.quantity.doubleValue(for: .gramUnit(with: .kilo))
            let currentWeightData = self.getMeasureForBodyWeight(bodyMass: weightInKilograms)
            completion(.success(()), currentWeightData.formattedBodyWeight, currentWeightData.currentMeasure)
        }
        
        healthStore.execute(query)
    }
    
    func fetchFatPercentage(completion: @escaping (Result<Void, Error>, _ fatPercent: String?) -> Void) {
        guard let fatPercentage = HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage) else {
            completion(.failure(NSError(domain: "HealthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "fatPercentage type is unavailable"])), nil)
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: fatPercentage, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, results, error in
            if let error = error {
                completion(.failure(error), nil)
                print("Failed to fetch fatPercentage: \(error.localizedDescription)")
                return
            }
            
            guard let result = results?.first as? HKQuantitySample else {
                completion(.failure(NSError(domain: "HealthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No fatPercentage data available"])), nil)
                print("No fatPercentage data available")
                return
            }
            
            let bodyFatPercentage = result.quantity.doubleValue(for: HKUnit.percent())
            completion(.success(()), String(bodyFatPercentage * 100))
        }
        
        healthStore.execute(query)
    }
    
    func getMeasureForDistance(distance: Double) -> (formattedDistance: String, currentMeasure: String) {
        let currentMeasure = UserDefaults.standard.string(forKey: Constants.distanceKey)
        
        switch currentMeasure {
        case Constants.kilometers:
            return (formattedDistance: (distance / 1000).formattedString() ?? "",
                    currentMeasure: "Progress.Kilometers.title".localized)
        case Constants.miles:
            return (formattedDistance: (distance / 1000 * 0.62137).formattedString() ?? "",
                    currentMeasure: "Progress.Miles.title".localized)
        default:
            return (formattedDistance: "", currentMeasure: "")
        }
    }
    
    func getMeasureForBodyWeight(bodyMass: Double) -> (formattedBodyWeight: String, currentMeasure: String) {
        let currentMeasure = UserDefaults.standard.string(forKey: Constants.bodyWeightKey)
        
        switch currentMeasure {
        case Constants.kgs:
            return (formattedBodyWeight: bodyMass.formattedString() ?? "", currentMeasure: "Progress.Kgs.title".localized)
        case Constants.pounds:
            let lbBodyMass = bodyMass * 2.20462
            return (formattedBodyWeight: lbBodyMass.formattedString() ?? "", currentMeasure: "Progress.Pounds.title".localized)
        case Constants.stones:
            let stBodyMass = bodyMass * 0.15747
            return (formattedBodyWeight: stBodyMass.formattedString() ?? "", currentMeasure: "Progress.Stones.title".localized)
        default:
            return (formattedBodyWeight: "", currentMeasure: "")
        }
    }
}

private extension HealthService {
    struct Constants {
        static let bodyWeightKey = "bodyWeightMeasureUnit"
        static let measurementsKey = "measurementsMeasureUnit"
        static let loadWeightKey = "loadWeightMeasureUnit"
        static let distanceKey = "distanceMeasureUnit"
        
        static let kgs = "kg"
        static let pounds = "lb"
        static let stones = "st"
        static let centimeters = "centimeters"
        static let inches = "inches"
        static let kilometers = "kilometers"
        static let miles = "miles"
    }
}

extension Date {
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

extension Double {
    func formattedString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
