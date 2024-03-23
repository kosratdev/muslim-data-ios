//
//
// ErrorWithRetryView.swift
// Example
//
// Created by Muhammad Azad on 23/03/2024
// Copyright © 2024 MuslimData. All rights reserved.
//
        

import SwiftUI

/// Displays an error message with a button to retry an action.
///
/// - Parameters:
///   - title: The title text displayed above the error message.
///   - errorMessage: The detailed error message to be presented to the user.
///   - retryAction: The closure to be executed when the "Retry" button is tapped.
struct ErrorWithRetryView: View {
    let title: String
    let errorMessage: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.headline)
            Text(errorMessage)
                .multilineTextAlignment(.center)
            Button(action: retryAction) {
                Label("Retry", systemImage: "arrow.clockwise")
            }
        }
    }
}

#Preview {
    ErrorWithRetryView(title: "Error loading data!",
                       errorMessage: "This is error messgae."){
        print("Retry")
    }
}
