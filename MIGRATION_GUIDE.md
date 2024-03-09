# Migration Guide

## MuslimDate Version 1.x to 2.x

### Introduction
This migration guide assists developers in transitioning from version 1.x to version 2.x of the `muslim-data-ios` library. Version 2 introduces improvements in database schema and table relations, including changes to the `Location` object structure.

### Changes Overview
- Improved database table normalization and rearranged table relations.
- Restructured the `Location` object schema for better data management and consistency.

### Migration Steps
**Update Location Object**
- Modify the `Location` object structure in your code to align with version 2.x.
  ```swift
  // Version 1.x
  public struct Location {
      public let latitude: Double
      public let longitude: Double
      public let cityName: String
      public let countryCode: String
      public let countryName: String
      public var hasFixedPrayerTime: Bool
  }
  
  // Version 2.x
  public struct Location {
      public let id: Int
      public let name: String
      public let latitude: Double
      public let longitude: Double
      public let countryCode: String
      public let countryName: String
      public var hasFixedPrayerTime: Bool
      public let prayerDependentId: Int?
  }
  ```
  - Add the `id` and `name` properties to the `Location` object to ensure consistency with the updated schema.
  - Update any references to the `Location` object throughout your codebase to use the new structure.

**Location Retrieval and Prayer Times**
- Update any methods or functions responsible for fetching user locations, geocoding, reverse geocoding, and obtaining prayer times to use the new `Location` object structure.

### Compatibility Notes
- Version 2.x maintains backward compatibility with existing projects using version 1.x, but requires modifications to the `Location` object structure.
- Ensure all dependencies and integrations with the library are updated to version 2.x to avoid compatibility issues.

### Testing Recommendations
- Thoroughly test your application after implementing the migration steps to ensure compatibility and functionality with the updated library version.

### Feedback
- Report any migration issues or suggestions for improvement [here](https://github.com/kosratdev/muslim-data-ios/issues).

### Versioning Information
- `muslim-data-ios` follows semantic versioning. Future updates will maintain backward compatibility whenever possible.
