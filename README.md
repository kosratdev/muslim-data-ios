# MuslimData

[![Build Status](https://github.com/kosratdev/muslim-data-ios/actions/workflows/deploy_to_cocoapods.yml/badge.svg)](https://github.com/kosratdev/muslim-data-ios/actions)
[![Version](https://img.shields.io/cocoapods/v/MuslimData.svg?style=flat)](https://cocoapods.org/pods/MuslimData)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
[![License](https://img.shields.io/cocoapods/l/MuslimData.svg?style=flat)](https://cocoapods.org/pods/MuslimData)
[![Platform](https://img.shields.io/cocoapods/p/MuslimData.svg?style=flat)](https://cocoapods.org/pods/MuslimData)

MuslimData is an Islamic library that provides Prayer Times (fixed and calculated), Offline Geocoder, Location Search, Azkars (Hisnul Muslim) and 99 Names of Allah.

**Fixed and Calculated Prayer Times**:
Most cities around the world find their prayer times by using some calculations which is based on location (longitude and latitude) but some other cities have fixed time table for their prayer times. This library contains most fixed and calculated prayer times. Now you can contribute it to improve it and also you can use it in Muslim communities or Muslim apps.

## Migration Guide
If you're upgrading from version 1.x to version 2.x of `muslim-data-ios`, please refer to the [Migration Guide](MIGRATION_GUIDE.md) for detailed instructions on updating your code to accommodate the changes in the latest release.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<img width="40%" src="https://raw.githubusercontent.com/kosratdev/muslim-data-ios/main/screenshots/1-prayer-times.png" /> <img width="40%" src="https://raw.githubusercontent.com/kosratdev/muslim-data-ios/main/screenshots/2-locations.png" /> <img width="40%" src="https://raw.githubusercontent.com/kosratdev/muslim-data-ios/main/screenshots/3-names.png" /> <img width="40%" src="https://raw.githubusercontent.com/kosratdev/muslim-data-ios/main/screenshots/4-azkars.png" /> <img width="40%" src="https://raw.githubusercontent.com/kosratdev/muslim-data-ios/main/screenshots/5-azkar-detail.png" />

## Requirements

* iOS 13.0+
* Xcode 11.0+

## Installation

### CocoaPods

MuslimData is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MuslimData'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding MuslimData as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift` or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/kosratdev/muslim-data-ios", .upToNextMajor(from: "2.0.0"))
]
```

##### Integrate with Xcode:

If you prefer to manage your Swift packages via Xcode, you can also add Muslim Data as a dependency using Xcode's UI:

1. Open your Xcode project.
2. Navigate to the `File` menu > `Swift Packages` > `Add Package Dependency...`.
3. Paste the Muslim Data GitHub repository URL (`https://github.com/kosratdev/muslim-data-ios.git`) into the search bar and click `Next`.
4. Choose the version rule (`Up to Next Major` from version `2.0.0`) and click `Next`.
5. Xcode will resolve the package and integrate it into your project.

## Usage 

### Location Helper 

There are some location helper methods that provides **offline** Location Search, Geocoder, Reverse Geocoder, and check a location for fixed prayer times.


#### Search for location

You can search for any cities or places around the world and this is useful when a use doesn't have internet connection or user's location is turned off so you can search here:
```swift
let locations = try! await MuslimRepository().searchLocation(locationName: "London")
guard let locations = locations, locations.count > 0 else {
    print("Location could not be found!")
    return
}
print("locations: \(locations)")
```

#### Geocoder 

Use geocoder to find a location by name.

```swift
// Use geocoder to find a location by name.
let location = try! await MuslimRepository().geocoder(countryCode: "GB", locationName: "London")
guard let location = location else {
    print("Location name can not be geocoded")
    return
}
print("location: \(location)")
```

#### Reverse Geocoder

Use reverse geocoder to find a location by latitude and longitude.

```swift 
// Use reverse geocoder to find a location by its latitude and longitude.
let location = try! await MuslimRepository().reverseGeocoder(latitude: 36.654090, longitude: 44.541278)
guard let location = location else {
    print("Location name can not be geocoded by latitude and longitude")
    return
}
print("location: \(location)")
```

### Prayer Times 

You can easily get a location prayer times just by passing (`Location`, `PrayerAttribute`, and `Date`) object to `getPrayerTimes` method.

```swift 
// Create location object.
let location = // it should be retrieved from geocoder, reverseGeocoder, or searchLocation methods.

// Crate prayer attributes object.
let attributes = PrayerAttribute(method: .makkah, asrMethod: .shafii, adjustAngle: .angleBased)

// Get prayer times
let prayerTime = try! await MuslimRepository().getPrayerTimes(location: location, date: Date(), attributes: attributes)

print("prayer times: \(prayerTime!)")
print("Fromat prayer times: \(prayerTime!.formatPrayers(.time12))")
print("Format one prayer time: \(prayerTime!.isha.toTime(format: .time24))")
print("next prayer index: \(prayerTime!.nextPrayerIndex())")
print("next prayer interval: \(prayerTime!.nextPrayerInterval())")
print("next prayer time remaining: \(prayerTime!.nextPrayerTimeRemaining())")
```

### Azkars (Hisnul Muslim)

Get all azkars from (**Hisnul Muslim** book) that is categorized by (`Category`, `Chapter`, and `Item`) and also the azkars are available for these languages (`en`, `ar`, `ckb`, `fa`, and `ru`)

#### Azkar Categories 

Get all azkar categories and it is localized for the given language.

```swift
// Get azkar categories from MuslimData library
let azkarCategories = try! await MuslimRepository().getAzkarCategories(language: .en)
print("Azkar Categories: \(azkarCategories!)")
```

#### Azkar Chapters

Get azkar chapters and it is localized for the given language.

```swift
// Get azkar chapters from MuslimData library
let azkarChapters = try! await MuslimRepository().getAzkarChapters(language: .en)
print("Azkar Chapters: \(azkarChapters!)")
```

Get azkar chapters for a specific category and it is localized for the given language.

```swift
// Get azkar chapters for a specific category from MuslimData library
let azkarChapters = try! await MuslimRepository().getAzkarChapters(language: .en, categoryId: 2)
print("Azkar Chapters for a category: \(azkarChapters!)")
```

#### Azkar Items

Get azkar items for a specific chapter and it is localized for the given language.
```swift
// Get azkar items for a specific chapter from MuslimData library
let azkarItems = try! await MuslimRepository().getAzkarItems(language: .en, chapterId: 2)
print("azkar items: \(azkarItems!)")
```

### Names of Allah 

Get 99 Names of Allah with it's translation and now it is available for these languages (`en`, `ar`, `ckb`, `fa`, and `ru`)

```swift
// Get 99 names of allah from MuslimData library
let namesOfAllah = try! await MuslimRepository().getNamesOfAllah(language: .en)
print("Names of Allah: \(namesOfAllah)")
```
## Author

Kosrat D. Ahmed, kosrat.d.ahmad@gmail.com

## License

MuslimData is available under the Apache license. See the [LICENSE](LICENSE) file for more info.
