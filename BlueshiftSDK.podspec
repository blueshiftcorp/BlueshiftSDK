#
# Be sure to run `pod lib lint BlueshiftSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'BlueshiftSDK'
  s.version               = '0.1.0'
  s.summary               = 'Official Blueshift SDK for developing iOS application.'
  
  s.description  = <<-DESC
  The Blueshift SDK for iOS enables you to develoip iOS application more easily using funtions such as:
  * Social Login to easily sign in users.
  * Sharing features like the Share or Message Dialog to grow your app.
  * Simpler Other API access to provide more social context.
  DESC
  
  s.homepage              = 'https://github.com/blueshiftcorp/BlueshiftSDK'
  s.license               = { :type => 'Blueshift SDK License', :file => 'LICENSE' }
  s.author                = 'Blueshift'
  s.homepage              = 'http://www.blueshift.co.kr'
  s.platform              = :ios, '13.0'
  s.source                = { :git => 'https://github.com/blueshiftcorp/BlueshiftSDK.git', :tag => s.version.to_s }
  #  s.source_files     = 'Source/Common/**/*'
  s.ios.deployment_target = '13.0'
  
  #  # Networking
  #  s.dependency      'Alamofire', '~> 5.4'
  #  s.dependency      'PromisedFuture'
  
  # Firebase Messaing / Push Notification
  #  s.dependency      'Firebase/Messaging'    # Firebase Cloud Messaging
  
  #  # Social Login
  #  s.dependency      'GoogleSignIn'          # Google Login
  #  s.dependency      'naveridlogin-sdk-ios'  # Naver Login
  #  s.dependency      'KakaoSDKAuth'          # 카카오 로그인
  #  s.dependency      'KakaoSDKUser'          # 사용자 관리
  
  #  # AES 암호화
  #  s.dependency      'CryptoSwift', '~> 1.4.1'
  
  s.subspec 'Common' do |ss|
    ss.source_files       = 'Source/Common/**/*'
  end
  
  s.subspec 'API' do |ss|
    ss.source_files       = 'Source/API/**/*'
    
    # Networking
    ss.dependency         'Alamofire', '~> 5.4'
    ss.dependency         'PromisedFuture'
  end
  
  #  s.subspec 'Util' do |ss|
  #    ss.source_files = 'Source/Util/**/*'
  #  end
  
  s.subspec 'UI' do |ss|
    ss.source_files       = 'Source/UI/**/*'
    
    #    ss.dependency 'BlueshiftSDK/Util'
  end
  
  s.subspec 'Login' do |ss|
    ss.source_files       = 'Source/Login/**/*'
    
    ss.dependency         'BlueshiftSDK/API'
    ss.dependency         'GoogleSignIn'          # Google Login
    ss.dependency         'naveridlogin-sdk-ios'  # Naver Login
    ss.dependency         'KakaoSDKAuth'          # 카카오 로그인
    ss.dependency         'KakaoSDKUser'          # 사용자 관리
  end
  
  s.subspec 'Messaging' do |ss|
    ss.source_files       = 'Source/Messaging'
    
    ss.dependency         'BlueshiftSDK/API'
    ss.dependency         'Firebase/Messaging'    # Firebase Cloud Messaging
  end
  
  s.subspec 'WebView' do |ss|
    ss.source_files       = 'Source/WebView'
    
    ss.dependency         'Alamofire', '~> 5.4'
    ss.dependency         'BlueshiftSDK/UI'
  end
  
end
