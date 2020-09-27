#
# Be sure to run `pod lib lint MediaLoader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MediaLoader'
  s.version          = '0.0.1'
  s.summary          = 'Wrapper for loading media'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MatiasSF9/MediaLoader'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MatiasSF9' => 'matiasrfer@gmail.com' }
  s.source           = { :git => 'https://github.com/MatiasSF9/MediaLoader.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/MatiasSF9'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'
  
  s.source_files = 'MediaLoader/Classes/**/*'

  # s.resource_bundles = {
  #   'MediaLoader' => ['MediaLoader/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
