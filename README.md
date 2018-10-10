# MuslimData

[![CI Status](https://img.shields.io/travis/KosratDAhmad/MuslimData.svg?style=flat)](https://travis-ci.org/KosratDAhmad/MuslimData)
[![Version](https://img.shields.io/cocoapods/v/MuslimData.svg?style=flat)](https://cocoapods.org/pods/MuslimData)
[![License](https://img.shields.io/cocoapods/l/MuslimData.svg?style=flat)](https://cocoapods.org/pods/MuslimData)
[![Platform](https://img.shields.io/cocoapods/p/MuslimData.svg?style=flat)](https://cocoapods.org/pods/MuslimData)

MuslimData is an Islamic library that provides Prayer Times (fixed and calculated), Offline Geocoder, and Location Search.

**Fixed and Calculated Prayer Times**:
Most cities around the world find their prayer times by using some calculations which is based on location (longitude and latitude) but some other cities have fixed time table for their prayer times. This library contains most fixed and calculated prayer times. Now you can contribute it to improve it and also you can use it in Muslim communities or Muslim apps.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 10.0+
* Xcode 10.0+

## Installation

MuslimData is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MuslimData'
```

## Usage 

### Search for location (offline)

You can search for any cities or places around the world and this is useful when a use doesn't have internet connection or user's location is turned off so you can search here:
```swift
LocationHelper.shared.citySearch(city: "London") { locations, error in
    guard let locations = locations, locations.count > 0 else {
        print("City could not be found!")
        return
    }
    print("locations: \(locations)")
}
```

## Author

Kosrat D. Ahmad, kosrat.d.ahmad@gmail.com

## License

MuslimData is available under the MIT license. See the LICENSE file for more info.
