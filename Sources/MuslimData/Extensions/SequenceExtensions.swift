//
//  File.swift
//  
//
//  Created by Kosrat Ahmed on 24/03/2024.
//

import Foundation

extension Sequence {
    /// Return a string of the array values without brackets.
    var minimalDescription: String {
        return map { "\($0)" }.joined(separator: ", ")
    }
}
