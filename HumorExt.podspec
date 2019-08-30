#
# Be sure to run `pod lib lint HumorExt.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HumorExt'
  s.version          = '0.1.2'
  s.summary          = 'Humor Extension'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/yuantrybest/HumorExt'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JLM' => 'yuanl@ccwcar.com' }
  s.source           = { :git => 'https://github.com/yuantrybest/HumorExt.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_versions = '5.0'

  s.source_files = 'HumorExt/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HumorExt' => ['HumorExt/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.frameworks = 'Foundation', 'UIKit'
  s.dependency 'RxCocoa'
  s.dependency 'RxSwift'
end
