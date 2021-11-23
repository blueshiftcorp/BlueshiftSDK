
Pod::Spec.new do |s|
  s.name                  = 'BlueshiftSDK'
  s.version               = '0.0.22'
  s.summary               = 'Official Blueshift SDK for developing iOS application.'
  
  s.description           = <<-DESC
                            BlueshiftSDK는 Swift, Interface Builder(xib) 기반의 어플리케이션 개발에 적합하도록 개발되었으며, 블루시프트 내부 개발자를 위한 iOS 어플리케이션 개발용 소프트웨어개발툴킷입니다.
                            일반 개발자를 위해 일부 프레임워크를 공개하고 있으나, 예고없이 기능의 일부 혹은 전부를 비공개로 전환하거나 수정 혹은 삭제될 수 있음을 양해해주십시오.
                            BlueshiftSDK는 하단메뉴를 포함하는 네비게이션, 테이블뷰 등으로 구성된 어플리케이션 개발에 특히 최적화되어 있습니다. 기본적으로 제공되는 기능은 아래와 같습니다.
                            * BSTabBarController
                            * BSViewController
                            * BSTableViewController
                            * API Module
                            * Common Utilities
                            DESC
  
  s.homepage              = 'https://github.com/blueshiftcorp/BlueshiftSDK'
  s.license               = { :type => 'Blueshift SDK License', :file => 'LICENSE' }
  s.author                = 'Blueshift'
  s.platform              = :ios, '13.5'
  s.source                = { :git => 'https://github.com/blueshiftcorp/BlueshiftSDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.5'
  s.swift_version         = '5.0'
  
  s.default_subspecs = 'Common', 'API', 'Login', 'Messaging', 'WebView'
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.subspec 'Common' do |ss|
    ss.source_files       = 'Source/Common/**/*'
  end
  
  s.subspec 'API' do |ss|
    ss.source_files       = 'Source/API/**/*'
    
    ss.dependency         'BlueshiftSDK/Common'
    ss.dependency         'Alamofire', '~> 5.4'   # Networking
    ss.dependency         'PromisedFuture'        # Async Process Management
  end
  
#  s.subspec 'UI' do |ss|
#    ss.source_files       = 'Source/UI/**/*'
#
#    ss.dependency         'BlueshiftSDK/Common'
#  end
  
  s.subspec 'Login' do |ss|
    ss.source_files       = 'Source/Login/**/*'
    
    ss.dependency         'BlueshiftSDK/API'
    ss.dependency         'GoogleSignIn'          # Google Login
    ss.dependency         'naveridlogin-sdk-ios'  # Naver Login
    ss.dependency         'KakaoSDKAuth'          # 카카오 로그인
    ss.dependency         'KakaoSDKUser'          # 사용자 관리
  end
  
  s.subspec 'Messaging' do |ss|
    ss.source_files       = 'Source/Messaging/**/*'
    
    ss.dependency         'BlueshiftSDK/API'
    ss.dependency         'Firebase/Messaging'    # Firebase Cloud Messaging
  end
  
  s.subspec 'WebView' do |ss|
    ss.source_files       = 'Source/WebView/**/*'
    
    ss.dependency         'Alamofire', '~> 5.4'
    ss.dependency         'BlueshiftSDK/Common'
#    ss.dependency         'BlueshiftSDK/UI'
  end
  
  s.subspec 'BLE' do |ss|
    ss.source_files       = 'Source/BLE/**/*'
  end
  
end
