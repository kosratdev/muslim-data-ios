//
//  PrayerAttribute.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/2/18.
//

import Foundation

public struct PrayerAttribute {
    public let calculationMethod: Prayer.CalculationMethods
    public let asrMethod: Prayer.AsrJuristicMethods
    public let adjustAngle: Prayer.AdjustingMethods
    public let latitude: Double
    public let longitude: Double
    public let timeZone: Double

    public init(calculationMethod: Prayer.CalculationMethods, asrMethod: Prayer.AsrJuristicMethods,
                adjustAngle: Prayer.AdjustingMethods, latitude: Double, longitude: Double, timeZone: Double) {
        self.calculationMethod = calculationMethod
        self.asrMethod = asrMethod
        self.adjustAngle = adjustAngle
        self.latitude = latitude
        self.longitude = longitude
        self.timeZone = timeZone
    }
}
