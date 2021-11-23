
Pod::Spec.new do |s|
  s.name                  = 'BlueshiftSDK'
  s.version               = '0.0.20'
  s.summary               = 'Official Blueshift SDK for developing iOS application.'
  
  s.description           = <<-DESC
                            The Blueshift SDK for iOS enables you to develoip iOS application more easily using funtions such as:
                            * Social Login to easily sign in users.
                            * Sharing features like the Share or Message Dialog to grow your app.
                            * Simpler Other API access to provide more social context.
                            DESC
  
  s.homepage              = 'https://github.com/blueshiftcorp/BlueshiftSDK'
  s.license               = { :type => 'Blueshift SDK License', :file => 'LICENSE' }
  s.author                = 'Blueshift'
  s.platform              = :ios, '13.0'
  s.source                = { :git => 'https://github.com/blueshiftcorp/BlueshiftSDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version         = '5.0'
  
  s.default_subspecs = 'Common', 'API', 'UI', 'Login', 'Messaging', 'WebView'
  
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
  
  s.subspec 'UI' do |ss|
    ss.source_files       = 'Source/UI/**/*'
    
    ss.dependency         'BlueshiftSDK/Common'
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
    ss.source_files       = 'Source/Messaging/**/*'
    
    ss.dependency         'BlueshiftSDK/API'
    ss.dependency         'Firebase/Messaging'    # Firebase Cloud Messaging
  end
  
  s.subspec 'WebView' do |ss|
    ss.source_files       = 'Source/WebView/**/*'
    
    ss.dependency         'Alamofire', '~> 5.4'
    ss.dependency         'BlueshiftSDK/UI'
  end
  
  s.subspec 'BLE' do |ss|
    ss.source_files       = 'Source/BLE/**/*'
  end
  
end
