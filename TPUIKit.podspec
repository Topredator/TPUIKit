#
# Be sure to run `pod lib lint TPUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TPUIKit'
  s.version          = '1.1.2'
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
  s.author           = { 'Topredator' => 'luyanggold@163.com' }
  s.source           = { :git => 'https://github.com/Topredator/TPUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'TPUIKit/Classes/TPUIKit.h'
  
  s.subspec 'Base' do |ss|
      ss.source_files = 'TPUIKit/Classes/Base/**/*'
      ss.resource_bundle = {
        'TPUIKitBase' => ['TPUIKit/Assets/Base.xcassets']
      }
  end
  s.subspec 'Category' do |ss|
      ss.source_files = 'TPUIKit/Classes/Category/**/*'
      ss.dependency 'TPUIKit/Base'
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
      ss.resource_bundle = {
          'TPUIKitRefresh' => ['TPUIKit/Assets/Refresh.xcassets']
      }
      ss.dependency 'Masonry'
      ss.dependency 'MJRefresh', '~> 3.1.14'
      ss.dependency 'TPUIKit/Base'
  end
  
  s.subspec 'Toast' do |ss|
      ss.source_files = 'TPUIKit/Classes/Toast/**/*'
      ss.dependency 'TPUIKit/Base'
      ss.dependency 'MBProgressHUD', '~> 1.1.0'
      ss.resource_bundle = {
          'TPUIKitToast' => ['TPUIKit/Assets/Toast.xcassets']
      }
  end
  
  s.subspec 'Blank' do |ss|
      ss.source_files = 'TPUIKit/Classes/Blank/**/*'
      ss.dependency 'TPUIKit/Base'
      ss.dependency 'Masonry'
      ss.resource_bundle = {
          'TPUIKitBlank' => ['TPUIKit/Assets/Blank.xcassets']
      }
  end
   
   s.subspec 'Banner' do |ss|
       ss.source_files = 'TPUIKit/Classes/Banner/**/*'
   end
   
   s.subspec 'Alert' do |ss|
       ss.source_files = 'TPUIKit/Classes/Alert/**/*'
   end
   
   s.subspec 'GraphicView' do |ss|
       ss.source_files = 'TPUIKit/Classes/GraphicView/**/*'
       ss.dependency 'Masonry'
   end
   
   s.subspec 'MarginLabel' do |ss|
       ss.source_files = 'TPUIKit/Classes/MarginLabel/**/*'
   end
   s.subspec 'Tabbar' do |ss|
       ss.source_files = 'TPUIKit/Classes/Tabbar/**/*'
       ss.dependency 'TPUIKit/Base'
   end
   
   s.subspec 'ScrollTable' do |ss|
       ss.source_files = 'TPUIKit/Classes/ScrollTable/**/*'
       ss.dependency 'TPUIKit/Base'
       ss.dependency 'TPUIKit/Tabbar'
       ss.dependency 'TPUIKit/Banner'
       ss.dependency 'Masonry'
   end
   
   s.subspec 'PageControl' do |ss|
       ss.source_files = 'TPUIKit/Classes/PageControl/**/*'
       ss.dependency 'TPUIKit/Base'
       ss.dependency 'Masonry'
   end
   s.subspec 'QRCode' do |ss|
       ss.source_files = 'TPUIKit/Classes/QRCode/**/*'
   end
   s.subspec 'ScreenShot' do |ss|
       ss.source_files = 'TPUIKit/Classes/ScreenShot/**/*'
   end
   s.subspec 'ShadowCell' do |ss|
       ss.source_files = 'TPUIKit/Classes/ShadowCell/**/*'
       ss.resource_bundle = {
           'TPUIShadowCell' => ['TPUIKit/Assets/ShadowCell.xcassets']
       }
       ss.dependency 'TPUIKit/Base'
   end
   s.subspec 'Menu' do |ss|
       ss.source_files = 'TPUIKit/Classes/Menu/**/*'
       ss.dependency 'TPUIKit/Base'
   end
   s.subspec 'RichTextView' do |ss|
       ss.source_files = 'TPUIKit/Classes/RichTextView/**/*'
       ss.dependency 'TPUIKit/Base'
   end
   s.subspec 'LimitTextField' do |ss|
     ss.source_files = 'TPUIKit/Classes/LimitTextField/**/*'
   end
   s.subspec 'Line' do |ss|
     ss.source_files = 'TPUIKit/Classes/Line/**/*'
   end
   
   s.subspec 'CustomLayout' do |ss|
     ss.source_files = 'TPUIKit/Classes/CustomLayout/**/*'
   end
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'Masonry'
end
