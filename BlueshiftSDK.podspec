#
# Be sure to run `pod lib lint BlueshiftSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BlueshiftSDK'
  s.version          = '0.1.0'
  s.summary          = 'Official Blueshift SDK for iOS to develop iOS application'

  s.description  = <<-DESC
                    The Blueshift SDK for iOS enables you to develoip iOS application more easily using funtions such as:
                    * Social Login to easily sign in users.
                    * Sharing features like the Share or Message Dialog to grow your app.
                    * Simpler Other API access to provide more social context.
                    DESC
  
  s.homepage         = 'https://github.com/blueshiftcorp/BlueshiftSDK'
  s.license          = { :type => 'Blueshift SDK License', :file => 'LICENSE' }
  s.author           = 'Blueshift'
  s.platform         = :ios, '13.0'
  s.source           = { :git => 'https://github.com/blueshiftcorp/BlueshiftSDK.git', :tag => s.version.to_s }
  s.source_files     = 'Source/**/*'
  s.ios.deployment_target = '13.0'
  
  s.dependency      'Alamofire', '~> 5.4'
  s.dependency      'PromisedFuture'

end
