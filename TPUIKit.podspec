#
# Be sure to run `pod lib lint TPUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TPUIKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of TPUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Topredator/TPUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Topredator' => 'zhouxiaolu@kaike.la' }
  s.source           = { :git => 'https://github.com/Topredator/TPUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'TPUIKit/Classes/TPUIKit.h'
  s.prefix_header_contents = '#import "TPUIKitDefine.h"'
  
  s.subspec 'Base' do |ss|
      ss.source_files = 'TPUIKit/Classes/Base/**/*'
  end
  
  s.subspec 'GradientView' do |ss|
      ss.source_files = 'TPUIKit/Classes/GradientView/**/*'
  end
  
  s.subspec 'Navigator' do |ss|
      ss.source_files = 'TPUIKit/Classes/Navigator/**/*'
  end
  
  s.subspec 'SimButton' do |ss|
      ss.source_files = 'TPUIKit/Classes/SimButton/**/*'
  end
  
  s.subspec 'Refresh' do |ss|
      ss.source_files = 'TPUIKit/Classes/Refresh/**/*'
      ss.resources = 'TPUIKit/Assets/Refresh.xcassets'
      ss.dependency 'Masonry'
      ss.dependency 'MJRefresh', '~> 3.1.14'
      ss.dependency 'TPUIKit/Base'
  end
  
  s.subspec 'Toast' do |ss|
      ss.source_files = 'TPUIKit/Classes/Toast/**/*'
      ss.dependency 'TPUIKit/Base'
      ss.dependency 'MBProgressHUD', '~> 1.1.0'
      ss.resources = 'TPUIKit/Assets/Toast.xcassets'
  end
  
  # s.resource_bundles = {
  #   'TPUIKit' => ['TPUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
