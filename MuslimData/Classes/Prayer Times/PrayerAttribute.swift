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
    public let timeZone: Double

    public init(calculationMethod: Prayer.CalculationMethods, asrMethod: Prayer.AsrJuristicMethods,
                adjustAngle: Prayer.AdjustingMethods, timeZone: Double) {
        self.calculationMethod = calculationMethod
        self.asrMethod = asrMethod
        self.adjustAngle = adjustAngle
        self.timeZone = timeZone
    }
}
