//
//  PrayerAttribute.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/2/18.
//

import Foundation

public struct PrayerAttribute {
    public let method: Prayer.CalculationMethods
    public let asrMethod: Prayer.AsrJuristicMethods
    public let adjustAngle: Prayer.AdjustingMethods
    public let offsets: [Double]

    public init(method: Prayer.CalculationMethods, asrMethod: Prayer.AsrJuristicMethods,
                adjustAngle: Prayer.AdjustingMethods, offsets: [Double]) {
        self.method = method
        self.asrMethod = asrMethod
        self.adjustAngle = adjustAngle
        self.offsets = offsets
    }
}
