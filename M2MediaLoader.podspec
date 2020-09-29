Pod::Spec.new do |s|
  s.name             = 'M2MediaLoader'
  s.version          = '0.2.0'
  s.summary          = 'Wrapper for loading media'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Allow to access user media library by leveraging classes like PHAsset'

  s.homepage         = 'https://github.com/M2-Media/M2MediaLoader'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MatiasSF9' => 'matiasrfer@gmail.com' }
  s.source           = { :git => 'https://github.com/M2-Media/M2MediaLoader', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MatiasSF9'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  
  s.source_files = 'M2MediaLoader/Classes/**/*'

  # s.resource_bundles = {
  #   'MediaLoader' => ['MediaLoader/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
