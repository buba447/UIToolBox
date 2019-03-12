#
# Be sure to run `pod lib lint UIToolBox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UIToolBox'
  s.version          = '1.0.4'
  s.summary          = 'The missing UIKit Toolbox. Easy to use extensions for UI, Layout and Animation.'

  s.description      =  'UIToolBox is a set of tools, extensions, and classes for developing UI for iOS in Swift. Many of the extensions are Missing Features and easy to use helpers for creating readable code. UIToolBox breaks down into three major parts: AutoLayout Extensions, Foundation Extensions, UI Extensions.'

  s.homepage         = 'https://github.com/buba447/UIToolBox'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'buba447' => 'buba447@gmail.com' }
  s.source           = { :git => 'https://github.com/buba447/UIToolBox.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/thewithra'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'

  s.source_files = 'UIToolBox/Classes/**/*'
  
end
