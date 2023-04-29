#
# Be sure to run `pod lib lint MuslimData.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MuslimData'
  s.version          = '1.4.0'
  s.summary          = 'Islamic library (Prayer Times [fixed and calculated], Names of Allah, and Azkars).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  MuslimData is an Islamic library that provides Prayer Times (fixed and calculated), Offline Geocoder, Location Search, Names of Allah, Azkars (Husnil Muslim).

  Fixed and Calculated Prayer Times
  Most cities around the world find their prayer times by using some calculations which is based on location (longitude and latitude) but some other cities have fixed time table for their prayer times. This library contains most fixed and calculated prayer times. Now you can contribute it to improve it and also you can use it in Muslim communities or Muslim apps.
                       DESC

  s.homepage         = 'https://github.com/KosratDAhmad/MuslimData'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kosrat D. Ahmad' => 'kosrat.d.ahmad@gmail.com' }
  s.source           = { :git => 'https://github.com/KosratDAhmad/MuslimData.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'MuslimData/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MuslimData' => ['MuslimData/Assets/*.png']
  # }

  s.swift_version = "5.0"
  s.resources = 'MuslimData/Assets/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'GRDB.swift', '~> 4.0.1'
end
