//
// File name : Utility+HealthKit.swift

// Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created Blueshift on 2021/09/07
//

import Foundation
import HealthKit

extension Util {
    
    public class HealthKit: NSObject {
        
        static let healthStore = HKHealthStore()
        
        static public func requestSteps(completion: @escaping (Double) -> Void) {
            
            guard let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
                  let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
                  let activeEnergyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
                return
            }
            
            let healthKitTypes: Set<HKObjectType> = [stepCount,
                                                     heartRate,
                                                     activeEnergyBurned
            ]
            
            healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) { (bool, error) in
                if let e = error {
                    print("oops something went wrong during authorisation \(e.localizedDescription)")
                    
                } else {
                    print("User has completed the authorization flow")
                    getTodaysSteps { (steps) in
                        completion(steps)
                    }
                }
            }
            
            if HKHealthStore.isHealthDataAvailable() {
                let authorizationStatus = healthStore.authorizationStatus(for: .workoutType())

                if authorizationStatus == .notDetermined {
                    print("healthkit authorization not determined.")

                } else if authorizationStatus == .sharingDenied {
                    print("Meditations doesn't have access to your workout data. You can enable access in the Settings application.")
                }

            } else {
                print("HealthKit is not available on this device.")
            }
        }
        
        static public func getStepsDuring(startDate: Date, endDate: Date, interval: NSDateComponents,completion: @escaping (Date, Double) -> Void) {
            let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            let calendar = NSCalendar.current
            let anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
            let anchorDate = calendar.date(from: anchorComponents)
            let query = HKStatisticsCollectionQuery(quantityType: stepsQuantityType,
                                                     quantitySamplePredicate: predicate,
                                                     options: .cumulativeSum,
                                                     anchorDate: anchorDate!,
                                                     intervalComponents: interval as DateComponents)
            query.initialResultsHandler = { query, results, error in
                if let mResult = results {
                    mResult.enumerateStatistics(from: startDate, to: endDate as Date) { (statistics, stop) in
                        if let quantity = statistics.sumQuantity() {
                            let date = statistics.startDate
                            let steps = quantity.doubleValue(for: HKUnit.count())
                            print("\(date) : steps = \(steps)")
                            completion(date, steps)
                        }
                    }
                    
                    var tSteps = [Double]()
                    for source in mResult.sources() {
                        print("Next Device: \(source.name)")
                        mResult.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                            if let quantity = statistics.sumQuantity() {
                                let date = statistics.startDate
                                let steps = quantity.doubleValue(for: HKUnit.count())
                                print("By Source -> \(date): \(steps)")
                                tSteps.append(steps)
                                print("collection of step : \(tSteps)")
                            }
                        }
                    }
                    
                    
                }
            }
            
            healthStore.execute(query)
        }
               
        static private func getTodaysSteps(completion: @escaping (Double) -> Void) {

            let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            
            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
            
            
            
            let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
                guard let result = result, let sum = result.sumQuantity() else {
                    print("Failed to fetch steps = \(error?.localizedDescription ?? "N/A")")
                    completion(0.0)
                    return
                }
                DispatchQueue.main.async {
                    completion(sum.doubleValue(for: HKUnit.count()))
                }
            }
            healthStore.execute(query)
            
        }
    }
}
